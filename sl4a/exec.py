#!/usr/bin/python3

import subprocess
import re
import android

droid=android.Android()

text=droid.dialogGetInput('Say somethin\'').result
if (text != ''):
	cmd=['busybox',text]
else:
	cmd=['busybox']

p=subprocess.Popen(cmd,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
print("Output:")
for line in iter(p.stdout.readline,""):
#	if (re.search("^root",line)):
	print(line.rstrip())
print("Errors:")
for line in iter(p.stderr.readline,""):
        print(line.rstrip())

