#!/usr/bin/python3

import math
import sys
import random_org as ro

main_range = ro.SequenceGenerator(int(sys.argv[1]), int(sys.argv[2]))

for i in main_range.getRez:
	prim = 1
	for j in range(2, int(math.sqrt(i)+1)):
		if i % j == 0:
			prim = 0
			break
	if prim == 1:
		print(i)

