#!/bin/bash

for file in *; do
    new_file=${file//[ ()]/_}
    if ! [[ "${file}" == "${new_file}" ]]; then
        mv "${file}" "${new_file}"
        if [[ $? == 0 ]]; then
            echo "Renamed ${file} to ${new_file}"
        fi
    fi
done

