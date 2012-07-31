#!/usr/bin/python

import os
import re

pid=os.getpid()

file=open('/proc/'+str(pid)+'/environ','r')
for line in file.readlines():
	line=line.rstrip()
	print(line)
	m=re.match("(.+)=(.+)",line)
	if (m):
		print(m.groups())
	else:
		print('No match')
file.close()

