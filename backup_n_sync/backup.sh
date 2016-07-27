#!/bin/bash

set -e

if ! [[ $(id -u) == 0 ]]; then
    echo "Must be ran with sudo."
    exit
fi

export PASSPHRASE=...
duplicity /home/slash file:///mnt/slash-rpi/home/slash
duplicity /etc file:///mnt/slash-rpi/etc
duplicity remove-older-than 3M --force file:///mnt/slash-rpi/home/slash
duplicity remove-older-than 3M --force file:///mnt/slash-rpi/etc

