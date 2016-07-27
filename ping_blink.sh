#!/bin/bash

IP=${1}

set -e

function set_trigger {
    local old_trigger
    old_trigger=$(grep -oE "\[.+\]" /sys/class/leds/led0/trigger|sed -r "s/(\[|\])//g")
    sudo sh -c 'echo "none">/sys/class/leds/led0/trigger'
    echo "${old_trigger}"
}

function light {
    sudo sh -c 'echo "255">/sys/class/leds/led0/brightness'
}

function dark {
    sudo sh -c 'echo "0">/sys/class/leds/led0/brightness'
}

function ping_host {
    ping -c 1 -W 1 "${1}" >/dev/null 2>&1
    echo $?
}

set_trigger
dark

while true ; do
    ret=$(ping_host "${IP}")
    echo "${ret}"
    # hosts responding
    if [[ ${ret} == 0 ]]; then
        light;sleep 1;dark;sleep 1
    # host not responding
    elif [[ ${ret} == 1 ]]; then
        light;sleep 0.1;dark;sleep 0.1
        light;sleep 0.1;dark
    # host does not exist
    elif [[ ${ret} == 2 ]]; then
        light;sleep 0.1;dark;sleep 0.1
        light;sleep 0.1;dark;sleep 0.1
        light;sleep 0.1;dark;sleep 1
    fi
done
