#!/bin/bash

docker pull alpine:edge
docker build -t slaash/dnsmasq .
