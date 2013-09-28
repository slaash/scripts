#!/usr/bin/python3

import math
import sys
import threading
import resource

min=int(sys.argv[1])
max=int(sys.argv[2])

class thr (threading.Thread):
	def __init__ (self,n):
		threading.Thread.__init__ ( self )
		self.n = n

	def run (self):
		ret=self.is_prime(self.n)
		if ret!=-1:
			print(self.name+" ("+str(self.ident)+")"+": "+str(ret))

	def is_prime(self,n):
		prim=1
		for i in range(2,int(math.sqrt(n))+1):
			if n % i == 0:
				prim=0
				break
		if prim == 1:
			return n
		return -1

for i in range(min,max+1):
	t=thr(i)
	t.start()
	runners=threading.active_count()
	if runners>=10:
		t.join()

print("Max RSS: "+str(resource.getrusage(resource.RUSAGE_SELF).ru_maxrss)+" kB")
