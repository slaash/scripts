#!/usr/bin/python3

import sys

def print(txt):
	sys.stdout.write(str(txt))

#array
dict={'a':1,'b':2,'c':3}

for i in dict.keys():
	print(i+":"+str(dict[i])+"\n")

dict={}

#hash of arrays
list=[1,2,3]
list1=['a','b','c']

dict[0]=list
dict[1]=list1

for i in dict.keys():
	print(str(i)+":")
	for j in dict[i]:
		print(str(j)+",")
	print("\n")

#array of hashes
list=[]

dict={'a':1,'b':2,'c':3}
dict1={'a':4,'b':5,'c':6}

list.append(dict)
list.append(dict1)

for i in list:
	print("List:\n")
	for j in i.keys():
		print("\t"+str(j)+":"+str(i[j])+"\n")

#hash of hashes
master_dict={}

dict={'a':1,'b':2,'c':3}
dict1={'a':4,'b':5,'c':6}

master_dict['issue1']=dict
master_dict['issue2']=dict1

for master_key in master_dict.keys():
	print("Key "+str(master_key)+": \n")
	for dict_key in master_dict[master_key].keys():
		print("\t"+str(dict_key)+":"+str(master_dict[master_key][dict_key])+"\n")


