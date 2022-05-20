#!/bin/bash

myDir="$(dirname "$0")"
source ${myDir}/retry.sh

for rel in focal jammy
do
    retry -s 20 -m 3 rsync -Lav rsync://cdimage.ubuntu.com/cdimage/releases/${rel}/release/*raspi.img.xz /repo/ubuntu-rpi
done
