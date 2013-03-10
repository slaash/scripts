#!/usr/bin/python3

import re

m=re.search("ama","mama")
print(m.group())

text="""1
2
3
4
5
6
"""

m=re.findall("\d+",text)
for i in m:
	print(i)

