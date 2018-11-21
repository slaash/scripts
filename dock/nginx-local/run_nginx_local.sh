#!/bin/bash

docker pull nginx:stable
docker stop nginx
docker rm nginx
docker run -d --name nginx --restart always -v /tmp/content:/usr/share/nginx/html:ro -p 8080:80 nginx:stable
