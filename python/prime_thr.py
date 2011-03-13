#!/usr/bin/python3

import math
import sys
import threading

min=int(sys.argv[1])
max=int(sys.argv[2])

class thr (threading.Thread):
        def run (self):
		print("threads:"+str(threading.active_count()))
                print("Started thread!\n")

def is_prime(n):
	prim=1
	for i in range(2,int(math.sqrt(n)+1)):
		if math.fmod(n,i) == 0:
			prim=0
			break
	if prim == 1:
		print(n)

for i in range(min,max+1):
	is_prime(i)
