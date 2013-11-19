#!/bin/bash

E_DID_NOTHING=-1

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

if ! ps qux ; then
  err "Unable to do_something"
  exit "${E_DID_NOTHING}"
fi
