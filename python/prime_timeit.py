#!/usr/bin/python3

import math
import sys
#import mem_info
import resource
import timeit

mn = int(sys.argv[1])
mx = int(sys.argv[2])

def myrange(start, stop):
	n = start
	while n < stop:
		yield n
		n += 1
def get_primes(mn,mx):
	for i in range(mn, mx+1):
		prim = 1
		for j in range(2, int(math.sqrt(i)+1)):
			if i % j == 0:
				prim = 0
				break
		if prim == 1:
			print(i)
print(timeit.timeit("get_primes(mn,mx)"))

