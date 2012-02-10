#!/usr/bin/python3

import socket
import threading
import pprint

class mainSrv(threading.Thread):
	clientsPanel={}

class worker (mainSrv):
	def __init__ (self,conn):
		threading.Thread.__init__(self)
		self.conn = conn

	def run (self):
		print("%s: connected to %s(%s):%s" % (self.getName(),socket.gethostbyaddr(self.conn.getpeername()[0])[0],self.conn.getpeername()[0],self.conn.getpeername()[1]))
		threadLock.acquire()
		self.clientsPanel[self.conn]=1
		threadLock.release()
		while 1:
			data = self.conn.recv(1024)
			pp=pprint.PrettyPrinter()
			if not data:
				break
			else:
				print("[%s(%s):%s]: %s" % (socket.gethostbyaddr(self.conn.getpeername()[0])[0],self.conn.getpeername()[0],self.conn.getpeername()[1],data.decode("utf-8").rstrip('\n')))
				self.conn.send("ok\n".encode("utf-8"))
				self.broadcast(data.decode("utf-8").rstrip('\n'))
				pp.pprint(self.clientsPanel)
		print("%s: Bye bye %s(%s):%s!" % (self.getName(),socket.gethostbyaddr(self.conn.getpeername()[0])[0],self.conn.getpeername()[0],self.conn.getpeername()[1]))
		threadLock.acquire()
		del self.clientsPanel[self.conn]
		threadLock.release()
		self.conn.close()

	def broadcast(self,txt):
		threadLock.acquire()
		for i in self.clientsPanel.keys():
			if i != self.conn:
				txt="["+str(socket.gethostbyaddr(self.conn.getpeername()[0])[0])+"("+str(self.conn.getpeername()[0])+"):"+str(self.conn.getpeername()[1])+"]: "+txt+"\n"
				i.send(txt.encode("utf-8"))
		threadLock.release()

threadLock = threading.Lock()

HOST = ''
PORT = 50007
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((HOST, PORT))
s.listen(1)
while (1):
        conn,addr=s.accept()
        t=worker(conn)
        t.start()

