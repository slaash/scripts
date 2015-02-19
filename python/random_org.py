#!/usr/bin/python3

import urllib, urllib.parse, urllib.request, urllib.error
from urllib.error import HTTPError
import re

class SequenceGenerator():

	base_url = "http://www.random.org/sequences/?"
	regex = "\d+"
	data=""

	def __init__(self, min = 1, max = 10, col = 1, format = 'plain', rnd = 'new'):
		self.min = int(min)
		self.max = int(max)
		self.col = int(col)
		self.format = format#html, plain
		self.rnd = rnd#new, id.identifier, date.isodate(YYYY-MM-DD, today, yesterday)

	def setNum(self, num):
		self.num = int(num)

	def setMin(self, min):
		self.num = int(min)

	def setMax(self, max):
		self.max = int(max)

	def makeParams(self):
		params = urllib.parse.urlencode({'min': self.min, 'max': self.max, 'col': self.col, 'format': self.format, 'rnd': self.rnd})
		return(params)

	def makeRequest(self):
		url = self.base_url + self.makeParams()
		print("URL: " + url)
		try:
			data = urllib.request.urlopen(url).read().decode('utf-8').rstrip()
		#that's python3, bitch!
		except HTTPError as err:
			print("You shit youself: ", err)
		else:
			self.data=data

	@property
	def getRez(self):
		#http://www.random.org/sequences/?min=1&max=52&col=1&format=plain&rnd=new 
		#http://www.random.org/integers/?num=10&min=1&max=6&col=1&base=10&format=plain&rnd=new
		#http://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=html&rnd=new
		#http://www.random.org/quota/?format=plain
		#http://www.random.org/quota/?ip=134.226.36.80&format=plain
		self.makeRequest()
		return(list(map(int,re.findall(self.regex, self.data))))

class IntegerGenerator(SequenceGenerator):

	base_url = "http://www.random.org/integers/?"

	def __init__(self, num = 1, min = 1, max = 10, col = 1, base = 10, format = 'plain', rnd = 'new'):
		super().__init__(min, max, col, format, rnd)
		self.num = num
		self.base = base#2,8,10,16

	def makeParams(self):
		params = urllib.parse.urlencode({'num': self.num, 'min': self.min, 'max': self.max, 'col': self.col, 'base': self.base, 'format': self.format, 'rnd': self.rnd})
		return(params)

class StringGenerator(SequenceGenerator):

	base_url = "http://www.random.org/strings/?"
	regex = ".+"

	def __init__(self, num=1, len=4, digits='off', upperalpha='off', loweralpha='on', unique='on', format = 'plain', rnd = 'new'):
		self.num = num
		self.len = len
		self.digits = digits
		self.upperalpha = upperalpha
		self.loweralpha = loweralpha
		self.unique = unique
		self.format = format
		self.rnd = rnd

	def makeParams(self):
		params = urllib.parse.urlencode({'num': self.num, 'len': self.len, 'digits': self.digits, 'upperalpha': self.upperalpha, 'loweralpha': self.loweralpha, 'unique': self.unique, 'format': self.format, 'rnd': self.rnd})
		return(params)

	@property
	def getRez(self):
		self.makeRequest()
		return(list(re.findall(self.regex, self.data)))
	
class QuotaChecker(SequenceGenerator):

	base_url = "http://www.random.org/quota/?"
	regex = "\d+"

	def __init__(self, ip='', format = 'plain'):
		self.ip = ip
		self.format = format

	def makeParams(self):
		params = urllib.parse.urlencode({'ip': self.ip, 'format': self.format})
		return(params)

if (__name__ == '__main__'):

	intFact = IntegerGenerator(num=10, max=100)
	print(intFact.getRez)

	seqFact = SequenceGenerator()
	print(seqFact.getRez)

	seqFact.setMax(max = 1000000000000000000000000)
	print(seqFact.getRez)

	strFact = StringGenerator(num=10, len=6, digits='on')
	print(strFact.getRez)

	qCheck = QuotaChecker()
	print(qCheck.getRez)

