#!/usr/bin/python

import os,sys

def findItem(d):
	try:
		files=os.listdir(d)
	except OSError, err:
		print(d+": "+str(err))
	else:
		print(d)
		for item in files:
			fullitem=os.path.join(d,item)
			if (os.path.isdir(fullitem)):
				findItem(fullitem)
			else:
				print(fullitem)

if (len(sys.argv)>1):
	d=sys.argv[1]
else:
	d="./"
findItem(d)

