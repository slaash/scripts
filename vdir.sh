#!/bin/bash

mode=${1}
dir=${2}

if [[ ${mode} == "size" ]]; then
    echo "Sorted by size"
    p_mode="%s %h\n"
else
    if [[ ${mode} == "time" ]];then
        echo "Sorted by time"
        p_mode="%TY-%Tm-%TdT%TH:%TM %h\n"
    else
        echo "usage: vdir.sh <size|time> <dir>"
        exit
    fi
fi

find ${dir} -type f -printf "${p_mode}" 2>/dev/null|sort -k 1 -n

