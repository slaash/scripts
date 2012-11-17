#!/usr/bin/python

from multiprocessing import Process,active_children,Queue
import sys,math

def is_prime(n,q):
	prim=1
	for i in range(2,int(math.sqrt(n))+1):
		if n % i == 0:
			prim=0
			break
	if prim == 1:
		q.put(n)

min=int(sys.argv[1])
max=int(sys.argv[2])

rezults=Queue()

for i in range(min,max+1):
	p=Process(target=is_prime,args=(i,rezults,))
	p.start()
	if len(active_children())>=10:
		p.join()

for p in active_children():
	p.join()

for r in range(1,rezults.qsize()+1):
	print(rezults.get())

