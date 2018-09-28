#!/bin/bash

docker pull debian:testing
docker build --no-cache -f Dockerfile.x64 -t slaash/ffmpeg .
