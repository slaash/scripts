#!/usr/bin/python3

import socket
import threading
import pprint

class mainSrv(threading.Thread):
	clientsPanel={}

class worker (mainSrv):
	def __init__ (self,conn):
		threading.Thread.__init__(self)
		self.conn=conn
		self.peerHost=""
		try:
			self.peerHost=socket.gethostbyaddr(self.conn.getpeername()[0])[0]
		except:
			pass
		self.peerAddr=self.conn.getpeername()[0]
                self.peerPort=self.conn.getpeername()[1]

	def run (self):
		print("%s: connected to %s(%s):%s" % (self.getName(),self.peerAddr,self.peerHost,self.peerPort))
		threadLock.acquire()
		self.clientsPanel[self.conn]=1
		threadLock.release()
		while 1:
			data = self.conn.recv(1024)
			if not data:
				break
			else:
				print("[%s(%s):%s]: %s" % (self.peerAddr,self.peerHost,self.peerPort,data.decode("utf-8").rstrip('\n')))
				self.conn.send("ok\n".encode("utf-8"))
				self.broadcast(data.decode("utf-8").rstrip('\n'))
				self.listThreads()
		print("%s: Bye bye %s(%s):%s!" % (self.getName(),self.peerAddr,self.peerHost,self.peerPort))
		threadLock.acquire()
		del self.clientsPanel[self.conn]
		threadLock.release()
		self.conn.close()

	def broadcast(self,txt):
		threadLock.acquire()
		for i in self.clientsPanel.keys():
			if i != self.conn:
				txt="["+self.peerAddr+"("+self.peerHost+"):"+str(self.peerPort)+"]: "+txt+"\n"
				i.send(txt.encode("utf-8"))
		threadLock.release()

	def listThreads(self):
		print("---List of clients---")
		for i in self.clientsPanel.keys():
			peerHost=""
			try:
				peerHost=socket.gethostbyaddr(i.getpeername()[0])[0]
			except:
				pass
			peerAddr=i.getpeername()[0]
			peerPort=i.getpeername()[1]
			txt=peerAddr+"("+peerHost+"):"+str(peerPort)
			print(txt)
		print("---------End---------")

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

