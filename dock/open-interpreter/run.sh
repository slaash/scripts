#!/bin/bash

set -euo pipefail

host_work_dir="$(pwd)/work"
host_convos_dir="${HOME}/open-convos"
container_home="/home/appuser"
container_convos_dir="$container_home/.config/open-interpreter/conversations"

mkdir -p "$host_work_dir" "$host_convos_dir"

docker run --name interpreter --rm -ti \
  -v "$host_work_dir:$container_home/work" \
  -v "$host_convos_dir:$container_convos_dir" \
  -w "$container_home/work" \
  slaash/open-interpreter \
  interpreter
