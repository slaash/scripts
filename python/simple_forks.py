#!/usr/bin/python3

import os
import time
import sys

runners=[]

for i in range(1,10):
	pid=os.fork()
	if pid==0:
		sys.stdout.write("Child waits 5 seconds... ")
		time.sleep(5)
		sys.stdout.write("child exits\n")
		sys.stdout.flush()
		exit()
	else:
		runners.append(pid)
		sys.stdout.write("Spawned child "+str(pid)+"\n")
		sys.stdout.flush()

sys.stdout.write("Waiting for all children to exit...\n")
sys.stdout.flush()

for child in runners:
	pid,code=os.waitpid(child,0)
	sys.stdout.write("Child "+str(pid)+" exits"+"\n")
	sys.stdout.flush()

