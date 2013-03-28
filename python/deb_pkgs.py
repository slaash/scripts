#!/usr/bin/python3

import urllib, urllib.parse, urllib.request, urllib.error
from urllib.error import HTTPError
import re

class QueryGenerator():

	def __init__(self, keywords, suite = 'all', arch = 'any', searchon = 'names', lang='en'):
		self.suite = suite
		self.arch = arch
		self.searchon = searchon
		self.keywords = keywords
		self.lang=lang
		self.setDistro('debian')

	def setSuite(self, suite):
		self.suite = suite

	def setArch(self, arch):
		self.arch = arch

	def setSearchon(self, searchon):
		self.searchon = searchon

	def setKeywords(self, keywords):
		self.keywords = keywords

	def setLang(self, lang):
		self.lang = lang

	def setDistro(self, dist):
		if (dist == 'debian'):
			self.base_url = "http://packages.debian.org/search?"
		elif (dist == 'ubuntu'):
			self.base_url = "http://packages.ubuntu.com/search?"
		else:
			print("Debian/Ubuntu only!")

	def makeParams(self):
		params = urllib.parse.urlencode({'suite': self.suite, 'arch': self.arch, 'searchon': self.searchon, 'keywords': self.keywords, 'lang': self.lang})
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
		#http://packages.debian.org/search?suite=all&arch=armel&searchon=names&keywords=aircrack
		self.makeRequest()
		pattern=re.compile(r'<div id="psearchres">(.+)</div>', re.MULTILINE|re.DOTALL)
		m=pattern.match(self.data)
		return(m.group())

if (__name__ == '__main__'):

	qGen = QueryGenerator(keywords='aircrack')
	qGen.setDistro('ubuntu')
	print(qGen.getRez)

