#!/usr/bin/python

import urllib2
import contextlib
import simplejson as json

class infoStruct(object):
#	def __init__(self, d):
#		for k,v in d.items():
#			if isinstance(v, dict):
#				setattr(self, k, infoStruct(v))
#			else:
#				setattr(self, k, v)

	def __init__(self, data=None):
		object.__setattr__(self, '.data', {} if data is None else data)

	def __call__(self):
		return getattr(self, '.data')

	def __getattr__(self, name):
		if isinstance(self()[name],dict):
			return infoStruct(self()[name])
		else:
			return self()[name]

#url="http://ipinfo.io/"
url="https://www.dailycred.com/api/info.json"

with contextlib.closing(urllib2.urlopen(url)) as f:
	data = json.load(f)

iS=infoStruct(data)

print iS.local.city, iS.local.countryName
print iS.local.longitude, iS.local.latitude
print iS.ip.ip
