#!/bin/bash

SRCDIR="${1%/}"
DSTDIR="${2%/}"

if [[ -z "$SRCDIR" || -z "$DSTDIR" ]]; then
    echo "Usage: $0 <source_dir> <dest_dir>"
    exit 1
fi

find "${SRCDIR}" \( -iname "*.mp3" -o -iname "*.m4a" -o -iname "*.flac" -o -iname "*.wv" \) \
| while IFS= read -r origFile; do
    fileName=$(basename "${origFile}")
    folderName=$(dirname "${origFile}")
    relFolder="${folderName#${SRCDIR}/}"   # strip SRCDIR + trailing slash
    baseName="${fileName%.*}"
    outDir="${DSTDIR}/${relFolder}"
    outFile="${outDir}/${baseName}.png"

    echo "${origFile} → ${outFile}"
    [[ -f "${outFile}" ]] && echo "Skipping (exists)" && continue

    mkdir -p "${outDir}"
    filter="showspectrumpic=s=1920x1080:mode=combined:color=magma:scale=log:fscale=lin:gain=8:drange=120:legend=1"
#    filter="showcqt=s=1920x1080:count=30:bar_g=2"
    ffmpeg -nostdin -i "${origFile}" \
        -lavfi "${filter}" \
        -update 1 "${outFile}"
done
