#!/bin/bash

DEST="/media/radu/7293-4524"
OPTS="--modify-window=1 -rt --delete"

for dir in /etc; do
    echo ${dir}
    sudo rsync ${OPTS} "${DEST}/$(hostname)"
    sudo sync
done

sudo rsync ${OPTS} --exclude-from 'exclude-list.txt' /home/radu "${DEST}/$(hostname)"
sudo sync
