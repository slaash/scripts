#!/usr/bin/python

def gen_list(min,max):
	for n in range(min,max):
		yield n

for i in gen_list(1,10):
	print(i)
