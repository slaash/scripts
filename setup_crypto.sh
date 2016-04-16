#!/bin/bash

sudo cryptsetup --verify-passphrase luksFormat /dev/sdb1 -c aes-xts-plain64 -s 512 -h sha512 -i 5000 --use-random
sudo cryptsetup luksOpen /dev/sdb1 securebackup
sudo mkfs.ext4 /dev/mapper/securebackup

