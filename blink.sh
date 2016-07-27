#!/bin/bash

set -e

function set_trigger {
    local old_trigger
    old_trigger=$(grep -oE "\[.+\]" /sys/class/leds/led0/trigger|sed -r "s/(\[|\])//g")
    sudo sh -c 'echo "none">/sys/class/leds/led0/trigger'
    echo "${old_trigger}"
}

function reset_trigger {
    sudo sh -c "echo \"${1}\">/sys/class/leds/led0/trigger"
}

function light {
    sudo sh -c 'echo "255">/sys/class/leds/led0/brightness'
}

function dark {
    sudo sh -c 'echo "0">/sys/class/leds/led0/brightness'
}

old_t=$(set_trigger)
for i in {1..3}; do
    light
    sleep 1
    dark
    sleep 1
done

echo "Resetting trigger from none to ${old_t}"
reset_trigger "${old_t}"

