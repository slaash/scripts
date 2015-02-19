#!/usr/bin/python

import zmq
import time
import zmqclient

cl = zmqclient.client(zmq.REQ,'tcp://127.0.0.1:5559')
print("Started requester {}".format(cl.data['id']))
cl.set_msg('Hello from frontend!')
while True:
	cl.send_jsn()
	time.sleep(1)
	d = cl.recv_jsn()
	print("{}# Client {}: {}".format(cl.data['id'], d['id'], d['msg']))

