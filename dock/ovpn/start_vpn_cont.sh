#!/bin/bash

docker stop vpn
docker rm vpn
docker run -d --name vpn --restart always --privileged --dns 127.0.0.1 --dns 8.8.8.8 --dns 8.8.4.4 -v ~/.uber:/opt/openvpn -v ${HOME}/.ssh:/root/.ssh slaash/ovpn

