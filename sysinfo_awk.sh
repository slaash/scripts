#!/bin/bash

awk 'BEGIN { printf "%-19s %-16s %-14s %-14s %s\n", "Date", "Free Memory (kB)", "Used Swap (kB)", "Free Swap (kB)", "System Load" }'

while true;
do
    meminfo=$(awk '
                   tolower($1) ~ /memfree/ { memfree = $2 }
                   tolower($1) ~ /swapfree/ { swapfree = $2 }
                   tolower($1) ~ /swaptotal/ { swaptotal = $2 }
                   END { printf "%-16s %-14s %-14s", memfree, swaptotal-swapfree, swapfree }' /proc/meminfo)
    echo "$(date +'%Y/%m/%d %H:%M:%S') ${meminfo} $(cut -d ' ' -f 1,2,3 /proc/loadavg)"
    sleep 5
done

