#!/usr/bin/python

import zmq
import time

ctx = zmq.Context()
s = ctx.socket(zmq.PUB)
s.bind('tcp://*:5555')
while True:
	s.send_string("aaa")
	time.sleep(1)

