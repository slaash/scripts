#!/bin/bash

docker ps|grep solr_webapp|awk '{ match($0, /\s+([a-zA-Z0-9_\-\.]+)$/, arr) ; print arr[1] }'
