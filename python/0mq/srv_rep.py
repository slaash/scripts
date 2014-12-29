#!/usr/bin/python

import zmq
import time

ctx = zmq.Context()
s = ctx.socket(zmq.REP)
s.bind('tcp://*:5555')
while True:
	msg = s.recv_string()
	print(msg)
	time.sleep(1)
	s.send_string("aaa")

