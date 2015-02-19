#!/bin/bash

if [ -z $1 ]; then
	ls -1tr /var/log/kismet/*.csv
else
	csvtool -t ";" -u TAB col 1,2,3,4,6,8,10,17,18,21,23,37,38 $1
fi

