#!/usr/bin/python

file=open('./file.txt','w')
file.write('This is a test!\n')
file.close()

file=open('./file.txt','r')
for line in file.readlines():
	print(line)
file.close

