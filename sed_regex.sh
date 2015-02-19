#!/bin/bash

pregex="^(\w+)\s+.+\s+[0-9]+:[0-9]+\s+(.+)"
ps aux|sed -En "s/$pregex/\1 \2/p"
