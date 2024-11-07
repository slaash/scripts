#!/bin/bash

SRCDIR=${1}
DSTDIR=${2}

find "${SRCDIR}" \( -iname "*.wav" \)| while read -r origFile;
do
    echo "${origFile}"
    dir=$(dirname "${origFile}")
    name=$(echo "${origFile}"|sed -e 's/.*\///g')
    flac=$(echo $name|sed -r 's/\.[^\.]+$/.flac/')
    dst="${DSTDIR}/${dir}/${flac}"
    mkdir -p "${DSTDIR}/${dir}"
    echo "${dst}"
    /opt/ffmpeg/bin/ffmpeg -y -i "${origFile}" -map 0:a -c:a flac -id3v2_version 3 "${dst}" < /dev/null
done
