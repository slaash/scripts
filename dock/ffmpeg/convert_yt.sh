#!/bin/bash

youtube-dl --restrict-filenames --no-call-home -x --audio-format=mp3 --audio-quality=128k -o "%(title)s.%(ext)s" "${1}"
