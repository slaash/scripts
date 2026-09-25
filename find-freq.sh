#!/bin/bash

find "${1}" -type f -iname "*.flac" -exec ffprobe -v error -select_streams a:0 -show_entries stream=sample_rate -show_entries format=filename -of default=noprint_wrappers=1 {} \;
