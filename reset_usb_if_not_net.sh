#!/bin/bash

resetusb="/opt/resetusb/resetusb"
log="/opt/resetusb/log.log"
trgt="192.168.172.1"

err=1
for i in {1..3}
do
	ping -c 1 $trgt >/dev/null 2>&1
	if [ $? != 0 ]; then
		echo "#$i: sleeping 1 sec..."
		sleep 1
	else
		err=0
		break
	fi
done

if [ $err == 1 ]; then
	date >> $log
	$resetusb >> $log 2>&1
	lsusb >> $log 2>&1
else
	echo "looks ok"
fi

