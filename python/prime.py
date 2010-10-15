#!/usr/bin/python

import math
import sys

min=int(sys.argv[1])
max=int(sys.argv[2])

for i in xrange(min,max+1):
	prim=1
	for j in xrange(2,int(math.sqrt(i)+1)):
		if math.fmod(i,j) == 0:
			prim=0
			break
	if prim == 1:
		print i

