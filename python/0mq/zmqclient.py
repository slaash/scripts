#!/usr/bin/python

import zmq
import random
import sys

class client():

	ctx = zmq.Context()
	data = dict()

	def __init__(self, mode, addr):
		self.s = self.ctx.socket(mode)
		self.s.connect(addr)
		self.data['id'] = random.randint(0, sys.maxint)
		self.data['msg'] = ''

	def set_msg(self, msg):
		self.data['msg'] = msg

	def send_msg(self):
		self.s.send_string("Client {}: {}".format(self.data['id'], self.data['msg']))

	def recv_msg(self):
		return self.s.recv_string()

	def send_jsn(self):
		self.s.send_json(self.data)

	def recv_jsn(self):
		return self.s.recv_json()

