#!/usr/bin/python

import zmq
import time
import zmqclient

cl = zmqclient.client(zmq.REP,'tcp://127.0.0.1:5560')
while True:
	print(cl.recv_msg())
	cl.send_msg("Hello!")
	time.sleep(1)

