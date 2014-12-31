#!/usr/bin/python

import zmq
import time
import zmqclient

cl = zmqclient.client(zmq.REP,'tcp://127.0.0.1:5560')
print("Started responder {}".format(cl.data['id']))
cl.set_msg('Hello from backend!')
while True:
	d = cl.recv_jsn()
	print("{}# Client {}: {}".format(cl.data['id'], d['id'], d['msg']))
	time.sleep(1)
	cl.send_jsn()

