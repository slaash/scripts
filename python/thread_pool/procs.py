#!/usr/bin/python

from multiprocessing import Process,Pipe,active_children

def hello(conn):
	conn.send(['Hello!'])
	conn.close()
	for i in range(1,1000000):
		pass

for i in range(1,10):
	p_conn,c_conn=Pipe()
	p=Process(target=hello,args=(c_conn,))
	p.start()
	print("{} {}".format(p.pid,p.name))
	print(p_conn.recv())
	print("Running: {}".format(len(active_children())))
#	for p in active_children():
#		print(p.pid)
#	p.join()

for p in active_children():
	p.join()


