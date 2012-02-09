#!/usr/bin/python3

import socket
import threading
import pprint

clientsPanel={}

class thr (threading.Thread):
	def __init__ (self,conn):
		threading.Thread.__init__(self)
		self.conn = conn

	def run (self):
		print("%s: connected to %s(%s):%s" % (self.getName(),socket.gethostbyaddr(self.conn.getpeername()[0])[0],self.conn.getpeername()[0],self.conn.getpeername()[1]))
		global clientsPanel
		clientsPanel[self.conn]=1
		while 1:
			data = self.conn.recv(1024)
			pp=pprint.PrettyPrinter()
			if not data:
				break
			else:
				print("[%s(%s):%s]: %s" % (socket.gethostbyaddr(self.conn.getpeername()[0])[0],self.conn.getpeername()[0],self.conn.getpeername()[1],data.decode("utf-8").rstrip('\n')))
				self.conn.send("ok\n".encode("utf-8"))
				self.broadcast(data.decode("utf-8").rstrip('\n'))
				pp.pprint(clientsPanel)
		print("%s: Bye bye %s(%s):%s!" % (self.getName(),socket.gethostbyaddr(self.conn.getpeername()[0])[0],self.conn.getpeername()[0],self.conn.getpeername()[1]))
		del clientsPanel[self.conn]
		self.conn.close()

	def broadcast(self,txt):
		for i in clientsPanel.keys():
			if i != self.conn:
				txt="["+str(socket.gethostbyaddr(self.conn.getpeername()[0])[0])+"("+str(self.conn.getpeername()[0])+"):"+str(self.conn.getpeername()[1])+"]: "+txt+"\n"
				i.send(txt.encode("utf-8"))

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

