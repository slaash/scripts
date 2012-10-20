#!/usr/bin/python

import sys

d=dict()
l=list()
max=10
if (len(sys.argv[1:])>=1):
	max=int(sys.argv[1])

for i in range(max):
	for j in range(max):
		l.append(i)
	d[i]=l
print('Done: {0} x {0}'.format(max))
raw_input()

