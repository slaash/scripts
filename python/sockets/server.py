#!/usr/bin/python3

import socket
import threading

class thr (threading.Thread):
	def __init__ (self,conn):
		threading.Thread.__init__ ( self )
		self.conn = conn

	def run ( self ):
		print("%s: connected to %s(%s):%s" % (self.getName(),socket.gethostbyaddr(self.conn.getpeername()[0])[0],self.conn.getpeername()[0],self.conn.getpeername()[1]))
		while 1:
			data = self.conn.recv(1024)
			if not data: break
			self.conn.send(data)
		print("%s: Bye bye %s(%s):%s!" % (self.getName(),socket.gethostbyaddr(self.conn.getpeername()[0])[0],self.conn.getpeername()[0],self.conn.getpeername()[1]))
		self.conn.close()

HOST = ''
PORT = 50007
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((HOST, PORT))
s.listen(1)
while (1):
	conn,addr=s.accept()
	t=thr(conn)
	t.start()

