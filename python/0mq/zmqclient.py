#!/usr/bin/python

import zmq
import random
import sys

class client():

	ctx = zmq.Context()

	def __init__(self, mode, addr):
		self.s = self.ctx.socket(mode)
		self.s.connect(addr)
		self.my_id = random.randint(0, sys.maxint)

	def send_msg(self, msg):
		self.s.send_string("Client {}: {}".format(self.my_id, msg))

	def recv_msg(self):
		return self.s.recv_string()

