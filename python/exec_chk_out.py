#!/usr/bin/python3

import subprocess,os

out=subprocess.check_output('ps')
print(out)

os.system('ps')

