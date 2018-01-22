#!/bin/bash

SRCDIR=${1}
DSTDIR=${2}

find "${SRCDIR}" \( -iname "*.mp3" -o -iname "*.m4a" -o -iname "*.flac" \)| while read -r origFile;
do
    echo "${origFile}"
    dir=$(dirname "${origFile}"|sed -e 's/.*\///g')
    name=$(echo "${origFile}"|sed -e 's/.*\///g')
    m4a=$(echo $name|sed -r 's/\.[^\.]+$/.m4a/')
    dst="${DSTDIR}/${dir}/${m4a}"
    mkdir -p "${DSTDIR}/${dir}"
    echo "${dst}"
    /opt/ffmpeg/bin/ffmpeg -y -i "${origFile}" -map 0:a -c:a libfdk_aac -b:a 128k -id3v2_version 3 "${dst}" < /dev/null
done
