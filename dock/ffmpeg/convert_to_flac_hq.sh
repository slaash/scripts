#!/bin/bash
set -euo pipefail

# Usage: convert_to_flac_hq.sh <SRCDIR> <DSTDIR>
# Converts audio files to FLAC at archival quality, preserving folder structure.
#   PCM sources (WAV, FLAC, AIFF, WV, APE): copied/re-encoded at native depth & rate
#   DSD sources (DSF, DFF):                 converted to 24-bit / 176.4 kHz PCM FLAC
# Non-audio files (artwork, cue sheets, etc.) are copied verbatim.

SRCDIR="${1:?Usage: $0 <SRCDIR> <DSTDIR>}"
DSTDIR="${2:?Usage: $0 <SRCDIR> <DSTDIR>}"

FFMPEG=/opt/ffmpeg/bin/ffmpeg

PCM_EXTS="wav|flac|aiff|aif|wv|ape|w64"
DSD_EXTS="dsf|dff"

find "${SRCDIR}" -type f | sort | while read -r origFile; do
    relPath="${origFile#${SRCDIR}/}"
    ext="${origFile##*.}"
    extLower="${ext,,}"

    if echo "${extLower}" | grep -qE "^(${DSD_EXTS})$"; then
        # --- DSD source: resample to 24-bit / 176.4 kHz ---
        flacRel="${relPath%.*}.flac"
        dst="${DSTDIR}/${flacRel}"
        mkdir -p "$(dirname "${dst}")"
        echo "[DSD→FLAC] ${relPath}"
        "${FFMPEG}" -y \
            -i "${origFile}" \
            -map 0:a \
            -map 0:v \
            -c:a flac \
            -compression_level 8 \
            -bits_per_raw_sample 24 \
            -sample_fmt s32 \
            -ar 176400 \
            -c:v copy \
            -disposition:v attached_pic \
            -map_metadata 0 \
            "${dst}" \
            < /dev/null

    elif echo "${extLower}" | grep -qE "^(${PCM_EXTS})$"; then
        # --- PCM source: re-encode at native depth & rate ---
        flacRel="${relPath%.*}.flac"
        dst="${DSTDIR}/${flacRel}"
        mkdir -p "$(dirname "${dst}")"
        echo "[PCM→FLAC] ${relPath}"
        "${FFMPEG}" -y \
            -i "${origFile}" \
            -map 0:a \
            -c:a flac \
            -compression_level 8 \
            -bits_per_raw_sample 24 \
            -sample_fmt s32 \
            -map_metadata 0 \
            "${dst}" \
            < /dev/null

    else
        # --- Non-audio: copy verbatim ---
        dst="${DSTDIR}/${relPath}"
        mkdir -p "$(dirname "${dst}")"
        echo "[COPY]     ${relPath}"
        cp -a "${origFile}" "${dst}"
    fi
done

echo "Done. Output: ${DSTDIR}"
