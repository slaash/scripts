#!/usr/local/bin/python3

from xml.etree.ElementTree import ElementTree

import pprint
pp = pprint.PrettyPrinter(indent=4)

basedir="/home/uidl9555/scripts"
file="bmw_to_CONTI_MM_2010_01_13T18-27-40.xml"

tree=ElementTree()
tree.dump('MSR-ISSUE')
tree.parse(basedir+"/"+file)
issue=tree.findall("ISSUES/ISSUE")
