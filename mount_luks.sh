#!/bin/bash

DEV=${1}

sudo cryptsetup luksOpen ${DEV} securebackup
sudo mount /dev/mapper/securebackup /mnt

