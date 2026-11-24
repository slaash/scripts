#!/bin/bash
#
# Download the best-quality audio of a YouTube video without re-encoding.
# Output is usually .opus (YouTube's best stream); tags and cover art embedded.
# Requires: yt-dlp, ffmpeg.

set -euo pipefail

main() {
  if (( $# != 1 )) || [[ -z "$1" ]]; then
    echo "Usage: $0 <youtube-url>" >&2
    exit 1
  fi

  # -x with --audio-format best extracts the stream as-is (no transcode).
  yt-dlp \
    --no-playlist \
    --restrict-filenames \
    -f bestaudio \
    -x --audio-format best \
    --embed-metadata --embed-thumbnail \
    -o '%(title)s.%(ext)s' \
    -- "$1"
}

main "$@"
