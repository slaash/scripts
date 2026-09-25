#!/usr/bin/env bash
set -euo pipefail

# Downloads all Jazz concert episode mp3s from romania-muzical.ro,
# mirroring them under a local static.srr.ro/... path (same layout as the source CDN).
SHOW_URL="${1:?usage: $0 <https://www.romania-muzical.ro/emisiuni/SLUG/ID>}"
DEST="$HOME/static.srr.ro"
echo "destination folder: $DEST"

SHOW_PATH="${SHOW_URL#https://www.romania-muzical.ro/emisiuni/}"
CURL="curl -s --connect-timeout 10 --max-time 30 --retry 2"

echo "fetching show page: $SHOW_URL"
years=$($CURL "$SHOW_URL" | grep -oE "href=\"/arhiva-emisiuni/$SHOW_PATH/[0-9]+\"" \
  | grep -oE '[0-9]+"' | tr -d '"' | sort -u)
echo "found years: $(echo "$years" | tr '\n' ' ')"

episode_pages=$(
  for y in $years; do
    echo "fetching archive page for year $y" >&2
    $CURL "https://www.romania-muzical.ro/arhiva-emisiuni/$SHOW_PATH/$y" \
      | grep -oE 'href="/emisiuni/es\.htm\?[^"]*"' | grep -oE '/emisiuni/es\.htm\?[^"]*'
  done | sort -u
)
echo "found $(echo "$episode_pages" | wc -l) episode pages"

for page in $episode_pages; do
  echo "fetching episode page: $page" >&2
  $CURL "https://www.romania-muzical.ro$page" \
    | grep -oE 'https://static\.srr\.ro/audio/[^"'"'"']*\.mp3' || true
done | sort -u | while read -r mp3_url; do
  path="${mp3_url#https://static.srr.ro/}"
  out="$DEST/$path"
  mkdir -p "$(dirname "$out")"
  if [[ -f "$out" ]]; then
    echo "resuming (already have $(du -h "$out" | cut -f1)): $path"
  else
    echo "downloading: $path"
  fi
  curl -S -f -C - --connect-timeout 10 --retry 2 -o "$out" "$mp3_url" \
    || { echo "ERROR: download failed for $mp3_url" >&2; exit 1; }
  echo "saved to: $out"
done
