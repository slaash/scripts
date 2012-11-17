#!/usr/bin/python

from multiprocessing.pool import ThreadPool

tPool=ThreadPool(10)

def hello(id):
	print("Hello!"+str(id))

#tPool.map(hello,[1,2,3])

for i in range(1,100):
	tPool.apply_async(hello,[i])

