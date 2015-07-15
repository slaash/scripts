#!/bin/bash

query="${1}"
host="${2}"
size=100
srv="192.168.172.200"

curl -s -X GET "http://${srv}:9200/files/_search?pretty=true&size=${size}" -d '
{
    "query": {
        "multi_match": {
            "query": "/etc/passwd raspberry-pi",
            "fields": [ "name", "host" ]
        }
    }
}'
echo ""
