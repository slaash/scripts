#!/bin/bash

sudo cryptsetup --verify-passphrase luksFormat /dev/sdb1 -c aes-xts-plain64 -s 512 -h sha512 -i 5000 --use-random
sudo cryptsetup luksOpen /dev/sdb1 securebackup
pv -tpreb /dev/zero | sudo dd of=/dev/mapper/securebackup bs=128M
sudo mkfs.ext4 /dev/mapper/securebackup
sudo mount /dev/mapper/securebackup /mnt
sudo umount /mnt 
sudo cryptsetup luksClose /dev/mapper/securebackup

sudo cryptsetup luksHeaderBackup /dev/sdb1 --header-backup-file ./head.out
sudo cryptsetup luksHeaderRestore /dev/sdb1 --header-backup-file ./head.out

