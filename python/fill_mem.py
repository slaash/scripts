#!/usr/bin/python

import sys,os

d=dict()
max=10
if (len(sys.argv[1:])>=1):
	max=int(sys.argv[1])
l=[0]*max

try:
	for i in range(max):
#	for j in range(max):
#		l.append(0)
		d[i]=l
#print(d)
except MemoryError,err:
	print('Out of memory? ',err)
#print("Done: {0} x {1}".format(i+1,max))
print("Done: %i x %i" % (i+1,max))
os.system('free -m')
raw_input()

