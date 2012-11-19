#!/usr/bin/python

from multiprocessing.pool import ThreadPool
import os,sys,re

def findItem(d,r):
	files=os.listdir(d)
	for item in files:
		if re.search(r,item):
			item=os.path.join(d,item)
			if os.path.islink(item):
				print("\t{} is link".format(item))
			elif os.path.isfile(item):
				print("\t{} is file".format(item))
			elif os.path.isdir(item):
				tPool.apply_async(findItem,[item,r])
			else:
				print("weird type...")

d=sys.argv[1]
r=sys.argv[2]
tPool=ThreadPool(4)
tPool.apply(findItem,[d,r])
tPool.terminate()
tPool.join()

