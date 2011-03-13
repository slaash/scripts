#!/usr/bin/python3

import threading

class thr (threading.Thread):
	def run (self):
		runners=threading.active_count()
		if (runners<=4):
		print("Started thread!\n")

thr().start()

