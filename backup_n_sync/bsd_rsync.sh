#!/bin/bash

for item in /etc /home/freebsd /boot/msdos/config.txt; do
    rsync -avz --exclude-from 'exclude-list.txt' -e ssh freebsd@...:${item} ./bsd
done

