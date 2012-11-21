#!/usr/bin/python

import os

for root,dirs,files in os.walk('../'):
	print(dirs)

