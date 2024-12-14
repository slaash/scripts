#!/bin/bash

set -e

SRCDIR=${1}
DSTDIR=${2}

find "${SRCDIR}" \( -iname "*.cue" \)| while read -r cueFile;
do
    dir=$(dirname "${cueFile}")
    dst="${DSTDIR}/${dir}"
    mkdir -p "${DSTDIR}/${dir}"
    dataFile=$(basename "${cueFile}")
    fullDataFile="${dir}/${dataFile%.cue}.flac"
    echo "${cueFile} ${dst} ${fullDataFile}"
    shnsplit -o flac -t "%n %t" -f "${cueFile}" -d "${dst}" "${fullDataFile}"
    find "${dst}" -name "*pregap*" -exec rm {} \;
    echo "cuetag \"${cueFile}\" \"${dst}/\"*"
    dos2unix "${cueFile}"
    cuetag "${cueFile}" "${dst}/"*
done
