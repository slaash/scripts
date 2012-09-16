#!/usr/bin/python3

import math
import sys
import os
import time

min=1
max=100

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
runners=[]

for i in range(min,max+1):
	pid=os.fork()
	if pid==0:
		is_prime(i)
		exit()
	else:
		runners.append(pid)
		if len(runners)>=parallel:
			pid,code=os.wait()
#			print("PID "+str(pid)+" exited with code "+str(code))
			runners.remove(pid)

#print("Now we wait for all children to exit..."+str(len(runners))+" bitches left!")
for child in runners:
	pid,code=os.waitpid(child,0)
#	print("PID "+str(pid)+" exited with code "+str(code))
#print("...Done\n")

