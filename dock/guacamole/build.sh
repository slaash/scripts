#!/bin/bash

docker pull debian:testing
docker build -f Dockerfile -t slaash/guacamole .
docker run -ti slaash/guacamole bash
#docker push slaash/guacamole
