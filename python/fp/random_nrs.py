#!/usr/bin/python

import random

random.seed()

rlist=list('1')
print(rlist)

def add_number(l):
	n=random.randint(0,100)
	if len(l)==0 or n not in l:
		l.append(n)
		return l
	else:
		add_number(l)


for i in range(0,100):
	rlist=add_number(rlist)

print(rlist)

