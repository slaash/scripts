#!/usr/bin/python3

import os
import time
import platform as pl

def showSomeInfo(d):
	print("---")
	for i in d.keys():
		s=""
		if (type(d[i])==type((1,2))):
			s+=i+": "
			for j in d[i]:
				s+=str(j)+" "
			print(s)
		else:
	        	print("{0}: {1}".format(i,d[i]))
	print("---")


def osInfo():
	try:
		info={'UID' : os.getuid(),
			'PID' : os.getpid(),
			'PWD' : os.getcwd(),
			'UNAME' : os.uname(),
			'Sys info' : os.times()}
	except AttributeError as err1:
		print("Error in getting os info: "+str(err1))
		info={}
	return(info)

def timeInfo():
	now = time.time()
	means = time.ctime(now)

def platfInfo():
	try:
		info={'arch' : pl.architecture(),
			'mach' : pl.machine(),
			'node' : pl.node(),
			'platform' : pl.platform(),
			'cpu' : pl.processor(),
			'python impl' : pl.python_implementation(),
			'python ver' : pl.python_version(),
			'release' : pl.release(),
			'system' : pl.system(),
			'version' : pl.version(),
			'dist' : pl.linux_distribution()}
	except AttributeError as err1:
		print("Error in getting platform info: "+str(err1))
		info={}
	return(info)

showSomeInfo(osInfo())
showSomeInfo(platfInfo())

