#!/bin/bash

cueFile="${1}"
dataFile="${2}"

shnsplit -o flac -t "%n %t" -f "${cueFile}" "${dataFile}"
