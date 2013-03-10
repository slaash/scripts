#!/usr/bin/python

import urllib
import re

class IntegerGenerator():

	def __init__(self, num = 1, min = 1, max = 10, col = 1, base = 10, format = 'plain', rnd = 'new'):
		self.num = num
		self.min = min
		self.max = max
		self.col = col
		self.base = base#2,8,10,16
		self.format = format#html, plain
		self.rnd = rnd#new, id.identifier, date.isodate(YYYY-MM-DD, today, yesterday)

	def setNum(self, num):
		self.num = num

	def setMin(self, min):
		self.num = min

	def setMax(self, max):
		self.max = max

	@property
	def getRez(self):
		#http://www.random.org/integers/?num=10&min=1&max=6&col=1&base=10&format=plain&rnd=new
		params = urllib.urlencode({'num': self.num, 'min': self.min, 'max': self.max, 'col': self.col, 'base': self.base, 'format': self.format, 'rnd': self.rnd})
		url = "http://www.random.org/integers/?" + params
		data = urllib.urlopen(url).read().rstrip()
		return(re.findall("\d+",data))

class SequenceGenerator():

	def __init__(self, min = 1, max = 10, col = 1, format = 'plain', rnd = 'new'):
		self.min = min
		self.max = max
		self.col = col
		self.format = format#html, plain
		self.rnd = rnd#new, id.identifier, date.isodate(YYYY-MM-DD, today, yesterday)

	@property
	def getRez(self):
		#http://www.random.org/sequences/?min=1&max=52&col=1&format=plain&rnd=new 
		params = urllib.urlencode({'min': self.min, 'max': self.max, 'col': self.col, 'format': self.format, 'rnd': self.rnd})
		url = "http://www.random.org/sequences/?" + params
		data = urllib.urlopen(url).read().rstrip()
		return(re.findall("\d+",data))

class StringGenerator():

	def __init__(self, num=1, len=4, digits='off', upperalpha='off', loweralpha='on', unique='on', format = 'plain', rnd = 'new'):
		self.num = num
		self.len = len
		self.digits = digits
		self.upperalpha = upperalpha
		self.loweralpha = loweralpha
		self.unique = unique
		self.format = format
		self.rnd = rnd
	
	@property
	def getRez(self):
		#http://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=html&rnd=new
		params = urllib.urlencode({'num': self.num, 'len': self.len, 'digits': self.digits, 'upperalpha': self.upperalpha, 'loweralpha': self.loweralpha, 'unique': self.unique, 'format': self.format, 'rnd': self.rnd})
		url = "http://www.random.org/strings/?" + params
		data = urllib.urlopen(url).read().rstrip()
		return(re.findall(".+",data))

intFact = IntegerGenerator(num=10, max=100)
print(intFact.getRez)

seqFact = SequenceGenerator()
print(seqFact.getRez)

strFact = StringGenerator(num=10, len=6, digits='on')
print(strFact.getRez)

