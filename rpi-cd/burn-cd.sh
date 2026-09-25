#!/usr/bin/env bash
set -euo pipefail

DEVICE="${CDROM_DEVICE:-/dev/sr0}"
INPUT_DIR="${1:?Usage: $0 <folder> [device]}"
[[ -n "${2:-}" ]] && DEVICE="$2"

WORK_DIR=$(mktemp -d)
trap 'rm -rf "$WORK_DIR"' EXIT

TOC="$WORK_DIR/album.toc"

# ── helpers ───────────────────────────────────────────────────────────────────

tag()            { metaflac --show-tag="$1" "$2" 2>/dev/null | sed "s/^$1=//i"; }
cd_text_escape() { printf '%s' "$1" | tr -d '"\\'; }

cue_to_frames() {
  local mm ss ff
  IFS=: read -r mm ss ff <<< "$1"
  echo $(( 10#$mm * 60 * 75 + 10#$ss * 75 + 10#$ff ))
}

frames_to_cue() {
  local f=$1
  printf '%02d:%02d:%02d' $(( f/75/60 )) $(( (f/75)%60 )) $(( f%75 ))
}

convert_flac() {  # args: input output sample_rate
  local -a opts=(-ar 44100 -ac 2 -sample_fmt s16)
  if [[ "$3" -ne 44100 ]]; then
    opts+=(-resampler soxr -af "aresample=resampler=soxr:precision=28")
  fi
  ffmpeg -loglevel warning -i "$1" "${opts[@]}" "$2"
}

write_toc_header() {  # args: album_title performer
  printf 'CD_DA\n\n'
  printf 'CD_TEXT {\n'
  printf '  LANGUAGE_MAP { 0 : EN }\n'
  printf '  LANGUAGE 0 {\n'
  printf '    TITLE "%s"\n'     "$1"
  printf '    PERFORMER "%s"\n' "$2"
  printf '  }\n}\n\n'
}

write_toc_track() {  # args: title performer wav [start_cue [length_cue]]
  printf 'TRACK AUDIO\n'
  printf 'CD_TEXT {\n'
  printf '  LANGUAGE 0 {\n'
  printf '    TITLE "%s"\n'     "$1"
  printf '    PERFORMER "%s"\n' "$2"
  printf '  }\n}\n'
  if [[ $# -eq 5 ]]; then
    printf 'FILE "%s" %s %s\n\n' "$3" "$4" "$5"
  elif [[ $# -eq 4 ]]; then
    printf 'FILE "%s" %s\n\n' "$3" "$4"
  else
    printf 'FILE "%s" 0\n\n' "$3"
  fi
}

# ── detect layout ─────────────────────────────────────────────────────────────

mapfile -t ALL_FLACS < <(find "$INPUT_DIR" -maxdepth 1 -iname '*.flac' | sort)
mapfile -t ALL_CUES  < <(find "$INPUT_DIR" -maxdepth 1 -iname '*.cue'  | sort)

if [[ ${#ALL_FLACS[@]} -eq 1 && ${#ALL_CUES[@]} -eq 1 ]]; then
  MODE="single"
elif [[ ${#ALL_FLACS[@]} -gt 1 ]]; then
  MODE="multi"
else
  echo "Error: expected one FLAC+CUE or multiple FLACs in $INPUT_DIR" >&2
  exit 1
fi

echo "Detected: $MODE-file layout (${#ALL_FLACS[@]} FLAC file(s))"

# ── single-file + CUE mode ────────────────────────────────────────────────────

if [[ "$MODE" == "single" ]]; then
  FLAC_FILE="${ALL_FLACS[0]}"
  CUE_FILE="${ALL_CUES[0]}"
  SR=$(metaflac --show-sample-rate "$FLAC_FILE")
  WAV="$WORK_DIR/album.wav"

  echo "Converting FLAC (${SR} Hz → 44100 Hz)..."
  convert_flac "$FLAC_FILE" "$WAV" "$SR"

  # Total CD frames derived from the FLAC's exact sample count
  # (588 samples per CD frame at 44100 Hz; bc gives floor division)
  FLAC_SAMPLES=$(metaflac --show-total-samples "$FLAC_FILE")
  TOTAL_FRAMES=$(echo "$FLAC_SAMPLES * 75 / $SR" | bc)

  # Parse CUE sheet
  ALBUM_TITLE="" ALBUM_PERFORMER=""
  TRACK_TITLES=() TRACK_PERFORMERS=() TRACK_STARTS=()
  cur_title="" cur_performer="" in_track=false

  while IFS= read -r line; do
    line="${line//$'\r'/}"                          # strip Windows CR
    stripped="${line#"${line%%[![:space:]]*}"}"     # trim leading whitespace
    case "$stripped" in
      TITLE\ *)
        val="${stripped#TITLE }"; val="${val#\"}"; val="${val%\"}"
        $in_track && cur_title="$val" || ALBUM_TITLE="$val" ;;
      PERFORMER\ *)
        val="${stripped#PERFORMER }"; val="${val#\"}"; val="${val%\"}"
        $in_track && cur_performer="$val" || ALBUM_PERFORMER="$val" ;;
      TRACK\ *\ AUDIO)
        in_track=true; cur_title=""; cur_performer="" ;;
      INDEX\ 01\ *)
        time="${stripped#INDEX 01 }"
        TRACK_STARTS+=( "$(cue_to_frames "$time")" )
        TRACK_TITLES+=( "$cur_title" )
        TRACK_PERFORMERS+=( "${cur_performer:-$ALBUM_PERFORMER}" ) ;;
    esac
  done < "$CUE_FILE"

  # Build TOC referencing offsets within the single WAV
  {
    write_toc_header "$(cd_text_escape "$ALBUM_TITLE")" \
                     "$(cd_text_escape "$ALBUM_PERFORMER")"
    N=${#TRACK_STARTS[@]}
    for (( i=0; i<N; i++ )); do
      start=${TRACK_STARTS[$i]}
      if (( i+1 < N )); then
        len=$(( TRACK_STARTS[i+1] - start ))
        write_toc_track \
          "$(cd_text_escape "${TRACK_TITLES[$i]}")" \
          "$(cd_text_escape "${TRACK_PERFORMERS[$i]}")" \
          "$WAV" \
          "$(frames_to_cue "$start")" \
          "$(frames_to_cue "$len")"
      else
        # Last track: omit length so cdrdao reads to end of file
        write_toc_track \
          "$(cd_text_escape "${TRACK_TITLES[$i]}")" \
          "$(cd_text_escape "${TRACK_PERFORMERS[$i]}")" \
          "$WAV" \
          "$(frames_to_cue "$start")"
      fi
    done
  } > "$TOC"
fi

# ── multi-file mode ───────────────────────────────────────────────────────────

if [[ "$MODE" == "multi" ]]; then
  mapfile -t FLACS < <(
    for f in "${ALL_FLACS[@]}"; do
      num=$(tag TRACKNUMBER "$f"); num="${num%%/*}"
      printf '%04d\t%s\n' "${num:-0}" "$f"
    done | sort -n | cut -f2-
  )

  ALBUM_TITLE=$(cd_text_escape "$(tag ALBUM "${FLACS[0]}")")
  ALBUM_ARTIST=$(cd_text_escape "$(tag ALBUMARTIST "${FLACS[0]}")")
  [[ -z "$ALBUM_ARTIST" ]] && ALBUM_ARTIST=$(cd_text_escape "$(tag ARTIST "${FLACS[0]}")")

  echo "Converting ${#FLACS[@]} tracks..."
  i=1; WAV_FILES=()
  for f in "${FLACS[@]}"; do
    out="$WORK_DIR/$(printf '%02d' $i).wav"
    SR=$(metaflac --show-sample-rate "$f")
    [[ "$SR" -ne 44100 ]] \
      && echo "  Resampling ${SR}→44100: $(basename "$f")" \
      || echo "  Decoding: $(basename "$f")"
    convert_flac "$f" "$out" "$SR"
    WAV_FILES+=("$out")
    i=$(( i + 1 ))
  done

  {
    write_toc_header "$ALBUM_TITLE" "$ALBUM_ARTIST"
    i=1
    for f in "${FLACS[@]}"; do
      title=$(cd_text_escape "$(tag TITLE  "$f")")
      artist=$(cd_text_escape "$(tag ARTIST "$f")")
      [[ -z "$artist" ]] && artist="$ALBUM_ARTIST"
      write_toc_track "$title" "$artist" "${WAV_FILES[$((i-1))]}"
      i=$(( i + 1 ))
    done
  } > "$TOC"
fi

# ── preview and burn ──────────────────────────────────────────────────────────

echo ""
echo "TOC preview:"
cat "$TOC"
echo ""

read -rp "Burn to $DEVICE? [y/N] " confirm
[[ "${confirm,,}" == "y" ]] || { echo "Aborted."; exit 0; }

cdrdao write --device "$DEVICE" --driver generic-mmc-raw --speed 8 "$TOC"
