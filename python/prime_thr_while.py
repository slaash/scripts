#!/usr/bin/python3

import sys
import math
import time
import threading

print("Min:")
min=int(sys.stdin.readline())
print("Max:")
max=int(sys.stdin.readline())
print("Threads:")
parallel=int(sys.stdin.readline())

class thr (threading.Thread):
	def __init__ (self,n):
		threading.Thread.__init__ ( self )
		self.n = n

	def run ( self ):
		ret=is_prime(self.n)
		if ret!=-1:
#			print("%s (%d): %d" % (self.getName(),threading.currentThread().ident,ret))
#			print("%s (%d): %d" % (self.getName(),self.ident,ret))
			print("%s: %d" % (self.getName(),ret))

def is_prime(n):
	prim=1
	i=2
	while i<=math.sqrt(n):
		if n % i == 0:
			prim=0
			break
		i+=1
	if prim == 1:
		return n
	return -1

start_time=time.time()

i=min
while i<=max:
	t=thr(i)
	t.start()
	runners=threading.activeCount()
	if runners>parallel:
		t.join()
	i+=1

print(str(len(threading.enumerate()))+" threads left")
for thrd in threading.enumerate():
        if thrd != threading.currentThread():
                thrd.join()

stop_time=time.time()

print("%d seconds" % (stop_time-start_time))

