#!/usr/bin/python

l=[]

print("{} {}".format(l,len(l)))

l.append(1)
l.append('a')
l.append('b')
l.append(2)

s1=1
s2='a'
s3='c'

if s1 in l:
	print(s1)

if s2 in l:
	print(s2)

if s3 not in l:
	print(s3)

