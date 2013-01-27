#!/usr/bin/python

import os

def get_status():
	file = open("/proc/{}/status".format(os.getpid()), 'r')
	for l in file.readlines():
		print(l.rstrip())
	file.close()

if __name__ == '__main__':
	get_status()
