#!/usr/bin/python3
#usage: ./script <-r> <-s pattern> <dir>

import os
import time
import sys
import re
import threading
import getopt

sys.argv.pop(0)
optlist,args=getopt.getopt(sys.argv,'rs:')

rec=False
search_expr="."
for o,a in optlist:
	if o=="-r":
		rec=True
	if o=="-s":
		search_expr=a

if len(args)>0:
	dir=args[0]
	if re.search("(.+)/$",dir)==None:
		dir=dir+"/"
else:
	dir="/"

filez={}

class thr (threading.Thread):
	def __init__ (self,dir):
		threading.Thread.__init__ ( self )
		self.dir = dir

	def run ( self ):
		global filez
		try:
			files=os.listdir(self.dir)
			time_fmt = "%d-%b-%Y %H:%M:%S"
			for item in files:
				if re.search(search_expr,item):
					item=os.path.join(self.dir,item)
					if os.path.exists(item) == True:
						size=os.path.getsize(item)
						mod_time=time.strftime(time_fmt,time.gmtime(os.path.getmtime(item)))
						if os.path.islink(item) == True:
							dest=os.readlink(item)
							filez[item]="->"+dest+"  "+str(size)+" bytes  "+str(mod_time)
						elif os.path.isfile(item) == True:
							filez[item]="  "+str(size)+" bytes  "+str(mod_time)
						elif os.path.isdir(item) == True:
							filez[item]="/ "+str(size)+" bytes  "+str(mod_time)
							if rec==True:
								t=thr(item+"/")
								t.start()
								if threading.activeCount()>10:
									t.join
					else:
						filez[item]=" is broken"
		except:
			filez[self.dir]=" can not be opened"

t=thr(dir)
t.start()
t.join()

for thrd in threading.enumerate():
	if thrd != threading.currentThread():
		thrd.join()

keys=filez.keys()
keys=list(keys)
keys.sort()

for item in keys:
	print(item+filez[item])

