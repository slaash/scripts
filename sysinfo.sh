#!/bin/bash

while true;
do
    echo "$(date +'%Y/%m/%d %H:%M:%S') $(grep -i memfree /proc/meminfo|tr -s ' ') $(grep -i swapfree /proc/meminfo|tr -s ' ') $(cut -d ' ' -f 1,2,3 /proc/loadavg)"
    sleep 5
done

