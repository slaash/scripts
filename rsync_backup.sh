#!/bin/bash

DEST="/media/radu/7293-4524/$(hostname)"
OPTS="--modify-window=1 -rtv --delete"

for dir in /etc; do
    echo ${dir}
    sudo rsync ${OPTS} "${DEST}"
    sudo sync
done

sudo rsync ${OPTS} --exclude-from 'exclude-list.txt' /home/radu "${DEST}"
sudo sync
