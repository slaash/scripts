#!/bin/bash
set -euo pipefail

# Downloads a YouTube video in best quality, remuxed to MP4 (H.264 + AAC).
# Prefers native H.264+AAC streams to avoid re-encoding; falls back to
# transcoding VP9/AV1+Opus when only those are available.
#
# Usage: convert_yt_video.sh <url>

if [[ $# -eq 0 ]]; then
    echo "Usage: $(basename "$0") <youtube-url>" >&2
    exit 1
fi

youtube-dl \
    --restrict-filenames \
    --no-call-home \
    -f "bestvideo[vcodec^=avc1][ext=mp4]+bestaudio[ext=m4a]/bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio" \
    --merge-output-format mp4 \
    --postprocessor-args "ffmpeg:-c:v libx264 -preset slow -crf 18 -c:a aac -b:a 192k" \
    -o "%(title)s.%(ext)s" \
    "${1}"
