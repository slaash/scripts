#!/usr/bin/python

import math
import sys

for i in range(int(sys.argv[1]), int(sys.argv[2])):
	prim = 1
	for j in range(2, int(math.sqrt(i)+1)):
		if i % j == 0:
			prim = 0
			break
	if prim == 1:
		print(i)

