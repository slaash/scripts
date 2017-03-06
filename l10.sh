#!/bin/bash

for i in $(ls -t file-*|tail -n +10);do
    echo "${i}"
done

