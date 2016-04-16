#!/bin/bash

function wait_key() {
    echo "Continue[Y/N]?"
    while read -r i; do
        if [[ ${i} == 'Y' || ${i} == 'y' ]]; then
            break;
        elif [[ ${i} == 'N' || ${i} == 'n' ]]; then
            exit
        fi
    done
    echo "You wanted to continue."
}

wait_key

