#!/usr/bin/python3

import sys
import socket
import threading

class thr (threading.Thread):
	def __init__ (self,conn):
		threading.Thread.__init__ ( self )
		self.conn = conn

	def run ( self ):
		print("Server thread started ("+self.getName()+")")
		while 1:
			data = self.conn.recv(1024)
			if not data: break
			self.conn.send(data)
		print("Bye bye %s(%s):%s !" % (socket.gethostbyaddr(self.conn.getpeername()[0])[0],self.conn.getpeername()[0],self.conn.getpeername()[1]))
		print(self.getName()+" finished")
		self.conn.close()

class mainsrv (threading.Thread):
	def __init__ (self,conn):
		threading.Thread.__init__ ( self )
		self.s = s

	def run ( self ):
		print("Main server thread started ("+self.getName()+")")
		while 1:
			conn,addr=s.accept()
			print("Connected by %s %s" % (addr[0],addr[1]))
			t=thr(conn)
			t.start()
		print(self.getName()+" finished")

HOST = ''
PORT = 50007
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((HOST, PORT))
s.listen(1)
srv=mainsrv(s)
srv.start()
#srv.join()

while 1:
	inp=sys.stdin.readline()
	inp.rstrip()
	if (inp=="q"):
		sys.exit(0)

