#!/usr/bin/python

import cPickle as pickle

a=[1,2,3]
b={'a':a}

file=open('./dump.txt','w')
pickle.dump(b,file)
file.close

file=open('./dump.txt','r')
b1=pickle.load(file)
file.close

print(b1['a'])

