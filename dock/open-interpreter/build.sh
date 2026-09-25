#!/bin/bash

docker pull python:latest
docker build -t slaash/open-interpreter -f Dockerfile .
