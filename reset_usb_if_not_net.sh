#!/bin/bash

resetusb = "/home/uidl9555/scripts/resetusb"

ping -c 1 192.168.172.1
if [ $? != 0 ]; then
	#$resetusb
	/home/uidl9555/scripts/resetusb
else
	echo "looks ok"
fi

