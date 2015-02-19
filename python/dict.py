#!/usr/bin/python

import pprint

pp=pprint.PrettyPrinter()

dict={'a':{1:2},'b':{2:3},'c':{3:4}}

pp.pprint(dict)

for i in dict.keys():
	print(str(i)+"=>")
	for j in dict[i].keys():
		print(str(j)+"=>"+str(dict[i][j]))

dict['d']={}
dict['d'][4]=5
dict['d'][5]=6

pp.pprint(dict)

