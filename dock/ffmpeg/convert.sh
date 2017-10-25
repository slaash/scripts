#!/bin/bash

SRCDIR=${1}

find "${SRCDIR}" -name "*.flac"| while read -r flac;
do
	echo "${flac}"
	dir=$(dirname "${flac}"|sed -e 's/.*\///g')
	name=$(echo "${flac}"|sed -e 's/.*\///g')
        mp3=${name//.flac/.mp3}
	dst="./mp3/${dir}/${mp3}"
	mkdir -p "./mp3/${dir}"
	echo "${dst}"
	/opt/ffmpeg/bin/ffmpeg -y -i "${flac}" -map 0:a -c:a libmp3lame -b:a 128k -id3v2_version 3 "${dst}" < /dev/null
done
