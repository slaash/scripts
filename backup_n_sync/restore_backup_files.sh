#!/bin/bash

set -e

if ! [[ $(id -u) == 0 ]]; then
    echo "Must be ran with sudo."
    exit
fi

export PASSPHRASE=...
#duplicity --file-to-restore samba/smb.conf file:///mnt/slash-rpi/etc /tmp/smb.conf
duplicity restore file:///mnt/slash-rpi/etc /tmp/etc

