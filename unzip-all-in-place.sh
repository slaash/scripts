#!/bin/bash

find . -name "*.zip" -type f|while read -r zipFile; do
    echo "${zipFile}"
    (
    dirName=$(dirname "${zipFile}")
    fileName=$(basename "${zipFile}")
    cd "${dirName}" || exit
    rm "${fileName}"
    )
done
