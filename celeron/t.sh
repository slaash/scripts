#!/bin/bash

w3m -o no_cache=true -o use_proxy=true -o http_proxy=http://127.0.0.1:8118/ http://$1

