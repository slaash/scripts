#!/usr/bin/python3

import socket
import os
import pprint

pp=pprint.PrettyPrinter()

HOST = ''
PORT = 50007

s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((HOST, PORT))
s.listen(1)
while (1):
	conn,addr=s.accept()
	pid=os.fork()
	if (pid==0):
		s.close()
		print("%s: connected to %s(%s):%s" % (os.getpid(),socket.gethostbyaddr(conn.getpeername()[0])[0],conn.getpeername()[0],conn.getpeername()[1]))
		while (1):
			data = conn.recv(1024)
			if not data:
				break
			else:
				print("[%s(%s):%s]: %s" % (socket.gethostbyaddr(conn.getpeername()[0])[0],conn.getpeername()[0],conn.getpeername()[1],data.decode("utf-8").rstrip('\n')))
				conn.send("ok\n".encode("utf-8"))
		print("%s: Bye bye %s(%s):%s!" % (os.getpid(),socket.gethostbyaddr(conn.getpeername()[0])[0],conn.getpeername()[0],conn.getpeername()[1]))
		conn.close()
		exit(0)

