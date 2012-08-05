import os
import re
import subprocess

def matchWords(line):
	res=['^Name','^VmSize','^VmPeak','^VmLib','^Threads','^Uid','^Gid']
	for r in res:
		if (re.search(r,line)):
			print(line)

def getStatus(pid):
	file=open('/proc/'+str(pid)+'/status','r')
	for line in file.readlines():
		line=line.rstrip()
		matchWords(line)
#		print(line)
	file.close()


def getCmdLine(pid):
	file=open('/proc/'+str(pid)+'/cmdline','r')
	for line in file.readlines():
		line=line.rstrip()
		print(line)
	file.close()

def getEnviron():
	p=subprocess.Popen(['busybox','env'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
	for line in p.stdout.readlines():
		line=line.rstrip()
		print(line)

pid=os.getpid()
ppid=os.getppid()
for id in (pid,ppid):
	getCmdLine(id)
	getStatus(id)
	print('-------')

getEnviron()
