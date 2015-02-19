#!/usr/local/bin/python3

import sys
import os
import time

r,w=os.pipe()
r,w=os.fdopen(r,'r'),os.fdopen(w,'w')

pid=os.fork()
if pid == 0:
	r.close()
	for i in range(0,10):
		print("Hello from "+str(os.getpid())+" at "+time.strftime("%d/%m/%Y %H:%M:%S ", time.localtime()),file=w)
		time.sleep(1)
		w.flush()
	exit()

w.close()
while 1:
	data=r.readline()
	if not data:
		break
	print("Data: "+data.strip())


