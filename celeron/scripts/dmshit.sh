#!/bin/bash

echo 0 `blockdev --getsize /dev/loop0` crypt blowfish 0123456789abcdef0123456789abcdef 0 /dev/loop0 0 | dmsetup create volume1

