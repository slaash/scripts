#!/usr/bin/python

from multiprocessing.pool import Pool
import os, sys

def find_item(d):
	try:
		files = os.listdir(d)
	except OSError, err:
		print(d+": "+str(err))
	else:
		print(d)
		for item in files:
			fullitem = os.path.join(d, item)
			if (os.path.isdir(fullitem)):
				tPool.apply_async(find_item, [fullitem])
#				findItem(fullitem)
			else:
				print(fullitem)

if (len(sys.argv)>1):
	s_dir = sys.argv[1]
else:
	s_dir = "./"

tPool = Pool(2)
tPool.apply(find_item, [s_dir])
tPool.close()
tPool.join()
#findItem(d)

