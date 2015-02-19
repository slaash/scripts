#!/bin/bash

out="$(host "$(uname -n)")"
echo "${out}"

