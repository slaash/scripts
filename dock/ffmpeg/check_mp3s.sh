#!/bin/bash


SRCDIR=${1}

find "${SRCDIR}" \( -iname "*.mp3" \)| while read -r origFile;
do
    echo "${origFile}"
    ffmpeg -i "${origFile}" -f null /dev/null 2>&1|grep -E "Input|Error while decoding"
done

