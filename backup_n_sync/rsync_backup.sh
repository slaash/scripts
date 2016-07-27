#!/bin/bash

DEST="${1}"

if ! [[ -d ${DEST} ]]; then
    echo "usage: $(basename ${0}) <destination folder>"
    exit
else
    echo "Using folder ${DEST}..."
    vdir "${DEST}"
    sleep 3
fi

if ! [[ -d ${DEST}/$(hostname) ]]; then
    sudo mkdir "${DEST}/$(hostname)"
    if ! [[ $? == 0 ]]; then
        echo "Error creating dir ${DEST}/$(hostname)"
        exit
    fi
fi

OPTS="--modify-window=1 -rt --delete"

for dir in /etc; do
    echo ${dir}
    sudo rsync ${OPTS} "${DEST}/$(hostname)"
    sudo sync
done

sudo rsync ${OPTS} --exclude-from 'exclude-list.txt' /home/slash "${DEST}/$(hostname)"
sudo sync
