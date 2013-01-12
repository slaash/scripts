#!/usr/bin/python3

import math
import sys

min=int(sys.argv[1])
max=int(sys.argv[2])

def myrange(start,stop):
	i = start
	while i < stop:
		yield i
		i += 1

for i in myrange(min,max+1):
	prim=1
	for j in myrange(2,int(math.sqrt(i)+1)):
		if i % j == 0:
			prim=0
			break
	if prim == 1:
		print(i)

