#!/usr/bin/python

import zmq

ctx = zmq.Context()
s = ctx.socket(zmq.SUB)
s.connect('tcp://127.0.0.1:5555')
s.setsockopt(zmq.SUBSCRIBE, '')
while True:
	print(s.recv_string())

