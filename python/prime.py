#!/usr/bin/python3

import math
import sys

min=int(sys.argv[1])
max=int(sys.argv[2])

for i in range(min,max+1):
	prim=1
	for j in range(2,int(math.sqrt(i)+1)):
		if math.fmod(i,j) == 0:
			prim=0
			break
	if prim == 1:
		print(i)

