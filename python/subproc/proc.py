#!/usr/bin/python3

import subprocess

command="ps"
pipe = subprocess.Popen(command)
pipe.close

