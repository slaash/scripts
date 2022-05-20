#!/bin/bash

myDir="$(dirname "$0")"
source ${myDir}/retry.sh

retry -s 20 -m 3 rsync -Lav rsync://ftp.cz.FreeBSD.org/pub/FreeBSD/doc/en/books /repo/freebsd
