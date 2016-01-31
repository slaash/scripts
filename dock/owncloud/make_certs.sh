#!/bin/bash

cd ~/ssl/

openssl genrsa -des3 -out server.key 1024 && openssl rsa -in server.key -out server.key.insecurexx && openssl req -new -key server.key -out server.csr && openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

