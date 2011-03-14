#!/usr/local/bin/python3

import os
import time

unumber = os.getuid()
pnumber = os.getpid()
where = os.getcwd()
what = os.uname()
used = os.times()
now = time.time()
means = time.ctime(now)

print("User number",unumber)
print("Process ID",pnumber)
print("Current Directory",where)
print("System information",what)
print("System information",used)

print("\nTime is now",now)
print("Which interprets as",means)

