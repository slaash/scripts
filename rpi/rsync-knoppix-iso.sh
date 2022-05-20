#!/bin/bash

myDir="$(dirname "$0")"
source ${myDir}/retry.sh

retry -s 20 -m 3 rsync -Lav rsync://mirror.netcologne.de/knoppix/KNOPPIX_V9*CD*EN.iso /repo/knoppix
retry -s 20 -m 3 rsync -Lav rsync://mirror.netcologne.de/knoppix/knoppix-cheatcodes.txt /repo/knoppix
