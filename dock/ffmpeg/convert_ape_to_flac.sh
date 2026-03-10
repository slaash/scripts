#!/bin/bash
set -euo pipefail

SRCDIR=$1

find "$SRCDIR" -type f -iname "*.ape" -print0 | \
while IFS= read -r -d '' origFile; do
    echo "Processing: $origFile"
    dir=$(dirname "$origFile")
    name=$(basename "$origFile")
    flac="${name%.*}.flac"
    dst="${dir}/${flac}"

    echo "Output: $dst"
    ffmpeg -nostdin -y -i "$origFile" -c:a flac "$dst"
done

