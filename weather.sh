#!/bin/bash

if [[ -z ${1+x} ]]; then
    curl -s http://wttr.in/iasi
else
    curl -s http://wttr.in/${1}
fi

