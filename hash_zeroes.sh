#!/bin/bash

getRandomString() {
    head /dev/urandom | tr -dc A-Za-z0-9 | head -c "${1}"
}

getStringHash() {
    echo -n "${1}"|/usr/bin/sha256sum|cut -d ' ' -f 1
}

c=30
myHash="ab"

while ! [[ "${myHash:0:4}" == "0000" ]] ; do
    myStr=$(getRandomString $c)
    myHash=$(getStringHash "${myStr}")
    echo "$c ${myStr} ${myHash}"
done

