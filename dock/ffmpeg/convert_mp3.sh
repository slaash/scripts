#!/bin/bash

SRCDIR=${1}
DSTDIR=${2}

find "${SRCDIR}" \( -name "*.mp3" -o -name "*.m4a" \)| while read -r flac;
do
	echo "${flac}"
	dir=$(dirname "${flac}"|sed -e 's/.*\///g')
	name=$(echo "${flac}"|sed -e 's/.*\///g')
        mp3=$(echo $name|sed 's/...$/mp3/')
	dst="${DSTDIR}/${dir}/${mp3}"
        mkdir -p "${DSTDIR}/${dir}"
	echo "${dst}"
	/opt/ffmpeg/bin/ffmpeg -y -i "${flac}" -map 0:a -c:a libmp3lame -b:a 128k -id3v2_version 3 "${dst}" < /dev/null
done

