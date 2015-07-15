#!/bin/bash

query="${1}"

curl -s -X POST "http://localhost:9200/files/_search?pretty=true&size=10000" -d "
{
    \"query\": {
        \"query_string\": {
            \"query\": \"*${query}*\",
            \"fields\": [\"name\"]
        }
    }
}"
echo ""
