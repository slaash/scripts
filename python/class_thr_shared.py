#!/usr/bin/python3

import threading
import time
import pprint

class mainObj(threading.Thread):
	
	n={}

class threadObj(mainObj):
	def __init__(self):
		threading.Thread.__init__(self)

	def run(self):
		threadLock.acquire()
		self.n[self.name]=1
		print("added "+self.name)
		threadLock.release()
		for i in range(1,5):
			time.sleep(1)
		threadLock.acquire()
		print("---")
		for i in self.n.keys():
			print(i)
		print("---")
		threadLock.release()

threadLock = threading.Lock()

for i in range(1,10):
	x=threadObj()
	x.start()

