#!/usr/bin/python3

import sys

#1
list=[]
for i in range(0,100):
	list.append(lambda x: x+1)

print(list[17](99))

#2?
try:
	sys.exit(0)
except:
	print("error")

#3
units = [1, 2]
tens = [10, 20]
nums = (a + b for a in units for b in tens)
units = [3, 4]
tens = [30, 40]
#print(nums.next())

#4
print("word" in [] == False)
print(("word" in []) == False)
#print("word" in ([] == False))

dict={1:2,3:4}
print(dict[2])

