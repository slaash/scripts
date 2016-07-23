#!/bin/bash

function light {
    sudo sh -c 'echo "255">/sys/class/leds/led0/brightness'
}

function dark {
    sudo sh -c 'echo "0">/sys/class/leds/led0/brightness'
}

sudo sh -c 'echo "none">/sys/class/leds/led0/trigger'
for i in {1..10}; do
    light
    sleep 1
    dark
    sleep 1
done

