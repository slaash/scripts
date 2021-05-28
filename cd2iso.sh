#!/bin/bash

newFile="${1}"

blocks=$(isosize -d 2048 /dev/sr0)
sudo dd if=/dev/sr0 of="${newFile}" bs=2048 count="${blocks}" status=progress
