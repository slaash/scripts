#!/bin/bash

f=${1}

ffmpeg -i "${f}" -vcodec msmpeg4 "${f}.avi"

#ffmpeg -i 5DIUk9IXUaI.mp4 -an -vcodec msmpeg4 -ss 00:00:08 -t 00:06:32 embriologie.avi
#mencoder -oac copy -ovc copy -idx -o embriologie_taiat.avi embriologie_part1.avi embriologie_part2.avi
#ffmpeg -ss 00:04:10 -i 5DIUk9IXUaI.mp4 -t 00:02:30 -an -vcodec msmpeg4 embriologie_part2.avi
#ffmpeg -ss 00:00:08 -i 5DIUk9IXUaI.mp4 -t 00:03:29 -an -vcodec msmpeg4 embriologie_part1.avi
#ffmpeg -i Mylene\ Farmer\ -\ C\'est\ \ une\ belle\ journée.mp3 -ss 01:26 -t 00:29 -acodec copy belle_journee.mp3
