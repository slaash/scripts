#!/usr/bin/python

import sys

nrs=int(sys.argv[1])
file=sys.argv[2]

fib=[1,1]

f=open(file,"w")

for i in range(2,nrs):
	fib.append(fib[i-1]+fib[i-2])

for elem in fib:
	f.write(str(elem)+"\n")

f.close()
