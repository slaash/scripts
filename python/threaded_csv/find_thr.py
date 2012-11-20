#!/usr/bin/python

from multiprocessing.pool import ThreadPool
import os,sys,re

def findItem(d,r):
	print("Dir: {}".format(d))
	if (os.path.exists(d)):
		files=os.listdir(d)
#	print(d,files)
		for item in files:
			fullitem=os.path.join(d,item)
			print(fullitem)
			if (os.path.isdir(fullitem)):
				print("start thread for {}".format(fullitem))
				tPool.apply_async(findItem,[fullitem,r])
	else:
		print("{} does not exist?".format(d))

if (len(sys.argv)>1):
	d=sys.argv[1]
	if (len(sys.argv)>2):
		r=sys.argv[2]
	else:
		r='.'
tPool=ThreadPool(2)
tPool.apply(findItem,[d,r])
tPool.close()
tPool.join()

