#!/bin/bash

count=0
find /usr|while read -r line;
do
    if [[ -f ${line} ]]; then
        md5sum ${line} &
        ((count+=1))
        if [[ $((count%10)) -eq 0 ]]; then
            wait
            echo ""
        fi
    fi
done
