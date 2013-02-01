#!/usr/bin/python

import random

random.seed()

rlist=[]

def add_number(l):
	n=random.randint(0,10)
	if n not in l:
		print("{} {}".format(l,len(l)))
		l.append(n)
		return l
	else:
		print("{} exists".format(n))
		l=add_number(l)


for i in range(0,10):
	rlist=add_number(rlist)

print(rlist)

