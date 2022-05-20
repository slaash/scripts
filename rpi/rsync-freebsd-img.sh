#!/bin/bash

myDir="$(dirname "$0")"
source ${myDir}/retry.sh

retry -s 20 -m 3 rsync -Lav rsync://ftp.cz.FreeBSD.org/pub/FreeBSD/releases/ISO-IMAGES/*/*RELEASE-*-RPI*.img.xz /repo/freebsd
retry -s 20 -m 3 rsync -Lav rsync://ftp.cz.FreeBSD.org/pub/FreeBSD/releases/ISO-IMAGES/*/*RELEASE-amd64-disc1.iso.xz /repo/freebsd
retry -s 20 -m 3 rsync -Lav rsync://ftp.cz.FreeBSD.org/pub/FreeBSD/releases/ISO-IMAGES/*/*RELEASE-amd64-memstick.img.xz /repo/freebsd
