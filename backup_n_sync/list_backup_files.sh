#!/bin/bash

set -e

if ! [[ $(id -u) == 0 ]]; then
    echo "Must be ran with sudo."
    exit
fi

export PASSPHRASE=...
duplicity list-current-files file:///mnt/slash-rpi/home/slash
duplicity list-current-files file:///mnt/slash-rpi/etc

