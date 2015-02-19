#!/usr/bin/python

import xml.etree.ElementTree as ET
import matplotlib

file='/home/slash/nbrfxrates2012.xml'
#file='./test.xml'

tree=ET.parse(file)
root=tree.getroot()
for elem in root.findall('Body/Cube'):
	print(elem.get('date'))
	for elem2 in elem.findall("Rate[@currency='EUR']"):
#		print(elem2.get('currency'))
		print(elem2.text)

