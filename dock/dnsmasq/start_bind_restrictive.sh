#!/bin/bash

docker stop bind
docker rm bind
docker run --name bind -d --restart always -p 54:53/tcp -p 54:53/udp -v /tmp/hosts:/hosts --cap-add=NET_ADMIN slaash/dnsmasq --hostsdir /hosts --log-queries --log-facility=- --server=1.1.1.1 --server=1.0.0.1 --no-resolv
