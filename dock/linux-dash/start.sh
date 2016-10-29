#!/bin/bash

docker rm -f linux-dash
docker run -d --restart=always --name linux-dash --privileged  --ipc="host" --network="host" --pid="host" -p 0.0.0.0:80:80 slaash/linux-dash

