#!/bin/bash

#curl -iH "Content-Type: application/json" -X GET http://localhost:6543/event -d '{
#   "events": [
#      {
#         "id": "6c743d66-20c5-4ba4-a377-f79c3c8a5b81",
#         "timestamp": "2016-10-01T12:54:37.490184835Z",
#         "action": "push",
#         "target": {
#            "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
#            "size": 1151,
#            "digest": "sha256:34a6d6a94dfd2bf9d100b4f1369dca734f1b76728bf2c7c749684f6f48b4d263",
#            "length": 1151,
#            "repository": "ubuntu",
#            "url": "https://docker.uberresearch.com/v2/ubuntu/manifests/sha256:34a6d6a94dfd2bf9d100b4f1369dca734f1b76728bf2c7c749684f6f48b4d263"
#         },
#         "request": {
#            "id": "c989b595-3b31-43ee-b62a-847b52c26007",
#            "addr": "86.124.148.90",
#            "host": "docker.uberresearch.com",
#            "method": "PUT",
#            "useragent": "docker/1.12.1 go/go1.6.3 git-commit/23cf638 kernel/4.4.0-38-generic os/linux arch/amd64 UpstreamClient(Docker-Client/1.12.1 \\(linux\\))"
#         },
#         "actor": {
#            "name": "radu@uberresearch.com"
#         },
#         "source": {
#            "addr": "e1bfae105f5c:5000",
#            "instanceID": "4566d75c-57e0-4c8f-8a0b-b0d1d2cfd712"
#         }
#      }
#   ]
#}'
#
#curl -iH "Content-Type: application/json" -X GET http://localhost:6543/event
#curl -iH "Content-Type: application/json" -X GET http://localhost:6543/event -d ''
#curl -iH "Content-Type: application/json" -X GET http://localhost:6543/event -d '{
#   "events": []}'

#curl -i -X GET 'http://localhost:6543/scan/ubuntu/latest/gigi@yahoo.com'
curl -i -X GET 'http://coreos-clair.vpn/scan/solr_webapp/V2.18_PI_release/gigi@yahoo.com'
