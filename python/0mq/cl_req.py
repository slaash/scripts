#!/usr/bin/python

import zmq
import time
import zmqclient

cl = zmqclient.client(zmq.REQ,'tcp://127.0.0.1:5559')
while True:
	cl.send_msg("Hello!")
	time.sleep(1)
	print(cl.recv_msg())

