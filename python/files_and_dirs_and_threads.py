#!/usr/bin/python3

import os
import time
import sys
import re
import threading

filez={}


if len(sys.argv)>1 and sys.argv[1]:
	dir=sys.argv[1]
	if re.match("(.+)/$",dir)==None:
		dir=dir+"/"
else:
	dir="/"

class thr (threading.Thread):
	def __init__ (self,dir):
		threading.Thread.__init__ ( self )
		self.dir = dir

	def run ( self ):
		print("Got "+self.dir)
		global filez
		try:
			files=os.listdir(self.dir)
			time_fmt = "%d-%b-%Y %H:%M:%S"
			for item in files:
				item=os.path.join(self.dir,item)
				if os.path.exists(item) == True:
					size=os.path.getsize(item)
					mod_time=time.strftime(time_fmt,time.gmtime(os.path.getmtime(item)))
					if os.path.islink(item) == True:
						dest=os.readlink(item)
#						print(item+"->"+dest+"  "+str(size)+" bytes  "+str(mod_time))
						filez[item]="->"+dest+"  "+str(size)+" bytes  "+str(mod_time)
					elif os.path.isfile(item) == True:
#						print(item+"  "+str(size)+" bytes  "+str(mod_time))
						filez[item]="  "+str(size)+" bytes  "+str(mod_time)
					elif os.path.isdir(item) == True:
#						print(item+"/i "+str(size)+" bytes  "+str(mod_time))
						filez[item]="/i "+str(size)+" bytes  "+str(mod_time)
						t=thr(item+"/")
						t.start()
						if threading.active_count()>10:
							t.join
				else:
#					print("Broken item: "+item)
					filez[item]=" is broken"
		except:
#                        print("Can not open "+self.dir)
			filez[self.dir]=" can not be opened"


t=thr(dir)
t.start()
t.join()

keys=filez.keys()
keys=list(keys)
keys.sort()

for item in keys:
	print(item+filez[item])

