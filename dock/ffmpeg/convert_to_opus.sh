#!/bin/bash

SRCDIR=${1}
DSTDIR=${2}

FFMPEG=/opt/ffmpeg/bin/ffmpeg

# Use soxr resampler if ffmpeg was built with --enable-libsoxr; fall back to swr otherwise
# libopus always resamples to 48 kHz internally, so soxr benefits every non-48 kHz source
if "${FFMPEG}" -buildconf 2>/dev/null | grep -q -- '--enable-libsoxr'; then
    RESAMPLE_FILTER=(-af "aresample=resampler=soxr")
else
    RESAMPLE_FILTER=()
fi

find "${SRCDIR}" \( -iname "*.mp3" -o -iname "*.m4a" -o -iname "*.flac" \)| while read -r origFile;
do
    echo "${origFile}"
    dir=$(dirname "${origFile}")
    name=$(echo "${origFile}"|sed -e 's/.*\///g')
    opus=$(echo $name|sed -r 's/\.[^\.]+$/.opus/')
    dst="${DSTDIR}/${dir}/${opus}"
    mkdir -p "${DSTDIR}/${dir}"
    echo "${dst}"
    "${FFMPEG}" -y -i "${origFile}" -map 0:a "${RESAMPLE_FILTER[@]}" -c:a libopus -b:a 192k -id3v2_version 3 "${dst}" < /dev/null
done

