#!/usr/bin/python

import json

d={'a':1, 'b':2, 'c':3}

def showDict(d):
	for k in d.keys():
	        print("{0} {1}".format(k,d[k]))

print(json.dumps(d))
showDict(d)

f=open('./json_test.dump','w')
json.dump(d,f)
f.close()

f=open('./json_test.dump','r')
new_d=json.load(f)
print(json.dumps(new_d))
showDict(new_d)

g=json.loads(json.dumps(d))
print(json.dumps(g))
showDict(g)

