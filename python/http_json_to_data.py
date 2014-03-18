#!/usr/bin/python

import urllib2
import contextlib
import simplejson as json
import time
import sys
import getopt

class infoStruct(object):
#	def __init__(self, d):
#		for k,v in d.items():
#			if isinstance(v, dict):
#				setattr(self, k, infoStruct(v))
#			else:
#				setattr(self, k, v)

	def __init__(self, data = None):
		object.__setattr__(self, '.data', {} if data is None else data)

	def __call__(self):
		return getattr(self, '.data')

	def __getattr__(self, name):
		if name in self().keys():
			if isinstance(self()[name], dict):
				return infoStruct(self()[name])
			else:
				return self()[name]
		else:
			return ''

#url="http://ipinfo.io/"
logFile = "/home/pi/location_info.txt"
url = "https://www.dailycred.com/api/info.json"
useProxy = 1
logOnly = 0
showHeaders = 0
sys.argv.pop(0)
try:
	optlist, args = getopt.getopt(sys.argv, 'hnu:l:o')
	for o, a in optlist:
		if o == '-n':
			useProxy = 0
		elif o == '-u':
			url = a
		elif o == '-l':
			logFile = a
		elif o == '-o':
			logOnly = 1
		elif o == '-h':
			showHeaders=1
except getopt.GetoptError as err:
	print(err)
	sys.exit()
if (useProxy == 1):
	proxy = urllib2.ProxyHandler({'http': '127.0.0.1:8118', 'https': '127.0.0.1:8118'})
	opener = urllib2.build_opener(proxy)
	urllib2.install_opener(opener)
try:
	with contextlib.closing(urllib2.urlopen(url)) as f:
		locData = json.load(f)
		if showHeaders == 1:
#			print(f.info().dict)
			print(f.info())
	iS = infoStruct(locData)
except urllib2.URLError as err:
	print(err)
	sys.exit()
if (logOnly == 0):
	print(iS.local.city, iS.local.countryName)
	print(iS.local.longitude, iS.local.latitude)
	print(iS.ip.ip)
try:
	f = open(logFile, 'a')
	f.write("{},{},{},{},{},{}\n".format(time.strftime("%Y-%m-%d %H:%M:%S"), iS.local.city, iS.local.countryName, iS.local.longitude, iS.local.latitude, iS.ip.ip))
	f.close()
except IOError as err:
	print(err)

