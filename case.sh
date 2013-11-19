#!/bin/bash

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

case "$1" in
  a)
    echo "a"
    ;;
  absolute)
    echo "abs"
    ;;
  *)
    err "Unexpected expression '$1'"
    ;;
esac
