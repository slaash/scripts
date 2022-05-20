#!/bin/bash

for arch in raspios_arm64 raspios_armhf
do
    wget -r -N -np -nH -t 3 -P /repo/raspios -e robots=off -A "*bullseye*.zip,*bullseye*.xz,*bullseye*.sha256" https://downloads.raspberrypi.org/${arch}/images/
done

