#!/usr/bin/python

import zmq
import time
import zmqclient

cl = zmqclient.client(zmq.SUB,'tcp://127.0.0.1:5555')
cl.s.setsockopt(zmq.SUBSCRIBE, '')
while True:
	print(cl.recv_msg())

