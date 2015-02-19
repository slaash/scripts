#!/bin/sh
kexec --load $1 --command-line="root=/dev/hda1 video=nvidiafb:1024x768-60 ro profile=2"
kexec --exec 
