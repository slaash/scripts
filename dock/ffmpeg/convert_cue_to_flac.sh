#!/bin/bash

cueFile="${1}"
dataFile="${2}"
dstDir="${3}"

echo "${dataFile}"
dir=$(dirname "${dataFile}")
echo "${dir}"
newDstDir="${dstDir}/${dir}"
echo "${newDstDir}"
mkdir -p "${newDstDir}"

shnsplit -o flac -t "%n %t" -f "${cueFile}" -d "${newDstDir}" "${dataFile}"
