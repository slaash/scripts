#!/bin/bash

if [[ -f /var/lib/dpkg/lock ]]; then
    echo "Waiting for dpkg to finish..."
    sleep 1
fi
