#!/usr/bin/python

import random

nrs=dict()

random.seed()

while (len(nrs.keys())<100):
	i=random.randint(0,100)
	nrs[i]=''

print(nrs.keys())
print(len(nrs.keys()))

