#!/bin/bash

trap cleanup HUP INT QUIT PIPE TERM

function cleanup () {
    docker-compose -f /opt/varnish/docker-compose.yml stop
    docker-compose -f /opt/varnish/docker-compose.yml rm -f
    }

export DOLLAR='$'
export BACKEND_HOST=$(ifconfig eth0 | awk '/inet addr/{print substr($2,6)}')
export BACKEND_URL="http://${BACKEND_HOST}:8888"

envsubst < /opt/varnish/docker-compose.yml.template > /opt/varnish/docker-compose.yml

docker-compose -f /opt/varnish/docker-compose.yml up -d
docker-compose -f /opt/varnish/docker-compose.yml logs -f &
wait $!

