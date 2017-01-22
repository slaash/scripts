#!/bin/bash

awk 'BEGIN { printf "%-19s %-23s %-15s\n", "Date", "Free Memory Free Swap", "System Load" }'

while true;
do
    meminfo=$(awk '
                   tolower($1) ~ /memfree/ { memfree = $2" "$3 }
                   tolower($1) ~ /swapfree/ { swapfree = $2" "$3 }
                   END { printf "%-11s %-11s", memfree, swapfree }' /proc/meminfo)
    echo "$(date +'%Y/%m/%d %H:%M:%S') ${meminfo} $(cut -d ' ' -f 1,2,3 /proc/loadavg)"
    sleep 5
done

