#!/bin/bash

cd /opt/letsencrypt
/opt/letsencrypt/certbot-auto -n --agree-tos --register-unsafely-without-email --apache -d home777.go.ro
