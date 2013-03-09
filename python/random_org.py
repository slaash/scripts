#!/usr/bin/python

import urllib

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

	def getRez(self):
		#http://www.random.org/integers/?num=10&min=1&max=6&col=1&base=10&format=plain&rnd=new
		params = urllib.urlencode({'num': self.num, 'min': self.min, 'max': self.max, 'col': self.col, 'base': self.base, 'format': self.format, 'rnd': self.rnd})
		url = "http://www.random.org/integers/?" + params
		data = urllib.urlopen(url).read().rstrip()
		return(data)

class SequenceGenerator():

	def __init__(self, min = 1, max = 10, col = 1, format = 'plain', rnd = 'new'):
		self.min = min
		self.max = max
		self.col = col
		self.format = format#html, plain
		self.rnd = rnd#new, id.identifier, date.isodate(YYYY-MM-DD, today, yesterday)

	def getRez(self):
		#http://www.random.org/sequences/?min=1&max=52&col=1&format=plain&rnd=new 
		params = urllib.urlencode({'num': self.num, 'min': self.min, 'max': self.max, 'col': self.col, 'base': self.base, 'format': self.format, 'rnd': self.rnd})
		url = "http://www.random.org/sequences/?" + params
		data = urllib.urlopen(url).read().rstrip()
		return(data)



intFact = IntegerGenerator()
intFact.setMax(1000000000)
print(intFact.getRez())

