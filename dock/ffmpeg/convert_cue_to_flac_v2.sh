#!/bin/bash

set -euo pipefail

SRCDIR=$1
DSTDIR=$2

# Ensure destination exists
mkdir -p "$DSTDIR"

# Use null-separated filenames for complete safety
find "$SRCDIR" -type f \( -iname "*.ape.cue" -o -iname "*.flac.cue" \) -print0 | \

while IFS= read -r -d '' cueFile; do
    echo "Processing: $cueFile"

    # Derive directories and filenames safely
    dir=$(dirname "$cueFile")
    relDir=${dir#"$SRCDIR"/}           # remove SRCDIR prefix for relative path
    dst="$DSTDIR/$relDir"
    mkdir -p "$dst"

    dataFile=$(basename "$cueFile")

    # Determine matching FLAC filename
    if [[ "$dataFile" == *.flac.cue ]]; then
        fullDataFile="$dir/${dataFile%.flac.cue}.flac"
    elif [[ "$dataFile" == *.ape.cue ]]; then
        fullDataFile="$dir/${dataFile%.ape.cue}.flac"
    else
        fullDataFile="$dir/${dataFile%.cue}.flac"
    fi

    echo "CUE: $cueFile"
    echo "SRC FLAC: $fullDataFile"
    echo "DEST: $dst"

    # Normalize line endings and encoding
    dos2unix -q "$cueFile"
    encoding=$(file -bi "$cueFile" | sed -n 's/.*charset=//p')
    if [[ "$encoding" != "utf-8" && "$encoding" != "us-ascii" ]]; then
        echo "🔤 Converting $cueFile from $encoding to UTF-8"
        iconv -f "$encoding" -t utf-8 "$cueFile" -o "${cueFile}.utf8" && mv "${cueFile}.utf8" "$cueFile"
    fi

    # Split tracks safely
    shnsplit -o flac -t "%n %t" -f "$cueFile" -d "$dst" "$fullDataFile"

    # Remove unwanted pregap tracks safely
    find "$dst" -type f -name "*pregap*" -print0 | xargs -0 rm -f --

    # Apply tags safely to each FLAC file
    find "$dst" -type f -name "*.flac" -print0 | while IFS= read -r -d '' flacFile; do
        echo "$cueFile $flacFile"
        cuetag "$cueFile" "$flacFile"
    done

    echo "✅ Finished: $cueFile → $dst"
    echo
done

