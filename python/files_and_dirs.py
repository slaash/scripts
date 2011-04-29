#!/usr/bin/python3

import os
import time
import sys
import re

if len(sys.argv)>1 and sys.argv[1]:
	dir=sys.argv[1]
	if re.match("(.+)/$",dir)==None:
		dir=dir+"/"
else:
	dir="/"

def list_dir(dir):
	files=os.listdir(dir)
	time_fmt = "%d-%b-%Y %H:%M:%S"
	for item in files:
		item=os.path.join(dir,item)
		if os.path.exists(item) == True:
			size=os.path.getsize(item)
			mod_time=time.strftime(time_fmt,time.gmtime(os.path.getmtime(item)))
			if os.path.islink(item) == True:
				dest=os.readlink(item)
				print(item+"->"+dest+"  "+str(size)+" bytes  "+str(mod_time))
			elif os.path.isfile(item) == True:
				print(item+"  "+str(size)+" bytes  "+str(mod_time))
			elif os.path.isdir(item) == True:
				print(item+"/i "+str(size)+" bytes  "+str(mod_time))
				list_dir(item+"/")
		else:
			print("Broken item: "+item)

list_dir(dir)

