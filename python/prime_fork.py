#!/usr/bin/python3

import math
import sys
import os
import time

min=int(sys.argv[1])
max=int(sys.argv[2])

def is_prime(n):
	prim=1
	for i in range(2,int(math.sqrt(n))+1):
		if n % i == 0:
			prim=0
			break
	if prim == 1:
		crt_pid=os.getpid()
		print(str(crt_pid)+" returned: "+str(n))
	return 0

parallel=5
running=0;

for i in range(min,max+1):
	pid=os.fork()
	if pid==0:
		is_prime(i)
#		exit()
	else:
#		print("Running children: "+str(running+1))
		running=running+1
		if running>=parallel:
#			print("Waiting...\n")
			os.wait()
			running=running-1
