#!/usr/bin/python

import subprocess
import re

p=subprocess.Popen('env',stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)

for line in p.stdout.readlines():
	line=line.rstrip()
	if (m=re.match("(.+)=(.+)"):
		print(m.groups(1)+" -> "+m.groups(2))
	print(line)


