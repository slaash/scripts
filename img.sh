#!/bin/bash

URL=${1}

asciiview <(curl -sk "${URL}")
