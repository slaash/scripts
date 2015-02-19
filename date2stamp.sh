#!/bin/bash

date2stamp () {
    date --utc --date "$1" +%s
}

stamp2date (){
    date --utc --date "1970-01-01 $1 sec" "+%Y-%m-%d %T"
}

dateDiff (){
    case $1 in
        -s)   sec=1;      shift;;
        -m)   sec=60;     shift;;
        -h)   sec=3600;   shift;;
        -d)   sec=86400;  shift;;
        *)    sec=86400;;
    esac
    dte1=$(date2stamp $1)
    dte2=$(date2stamp $2)
    diffSec=$((dte2-dte1))
    if ((diffSec < 0)); then abs=-1; else abs=1; fi
    echo $((diffSec/sec*abs))
}

startime=`who -b|tr -s ' '|cut -d ' ' -f 4,5`
#echo "ST: $startime"
startime_tstamp=$(date2stamp "$startime")
#echo "ST: $startime_tstamp"
calculated_tstamp=$(($startime_tstamp+$1))
#echo "CT: $calculated_tstamp"

new_time=$(stamp2date "$calculated_tstamp")
echo $new_time

