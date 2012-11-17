#!/usr/bin/python

from multiprocessing.pool import ThreadPool
import math
import sys

def is_prime(n):
	prim=1
	for i in range(2,int(math.sqrt(n))+1):
		if n % i == 0:
			prim=0
			break
	if prim == 1:
		return n
	return -1

min=int(sys.argv[1])
max=int(sys.argv[2])

tPool=ThreadPool(10)
rez=tPool.map_async(is_prime,range(min,max))
for i in rez.get():
	if (i!=-1):
		print(i)
