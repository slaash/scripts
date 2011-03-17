#!/usr/local/bin/python3

import sys

sys.path=["/usr/local/lib/python3.2",sys.path]

print(sys.executable)
print(sys.path)

from xml import etree
from etree import ElementTree

basedir="/home/slash/scripts";
file="bmw_to_CONTI_MM_2010_01_13T18-27-40.xml"

#tree=ElementTree()
#tree.parse(basedir+"/"+file)

