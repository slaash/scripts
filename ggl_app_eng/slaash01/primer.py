#!/usr/bin/env python

import cgi
import json

import webapp2

from google.appengine.ext import db
from google.appengine.api import runtime

import math

class PrimerInfo(db.Model):
        date = db.DateTimeProperty(auto_now_add=True)
        de_la = db.StringProperty()
        la = db.StringProperty()
        numbers = db.StringProperty()

class PrimerHandler(webapp2.RequestHandler):

	def getPrimes(self,de_la,la):
		de_la=int(de_la)
		la=int(la)
		primes=[]
		for i in range(de_la,la+1):
			prim=1
			for j in range(2,int(math.sqrt(i)+1)):
				if i % j == 0:
					prim=0
					break
			if prim == 1:
				primes.append(i)
		print(primes)
		return(primes)

	def setPrimerInfo(self,de_la,la,numbers):
		pr=PrimerInfo()
		pr.de_la=de_la
		pr.la=la
		pr.numbers=numbers
		pr.put()

	def get(self):
		de_la=cgi.escape(self.request.get('de_la'))
		la=cgi.escape(self.request.get('la'))
		self.response.out.write("get: hello from backend!")
		self.setPrimerInfo('111','222',','.join(self.getPrimes(de_la,la)))

	def post(self):
		de_la=str(cgi.escape(self.request.get('de_la')))
		la=str(cgi.escape(self.request.get('la')))
		self.response.out.write("post: hello from backend!")
		self.setPrimerInfo('111','222',','.join(self.getPrimes(de_la,la)))

class StartHandler(webapp2.RequestHandler):
	"""Handler for '/_ah/start'.
	This url is called once when the backend is started.
	"""
	def get(self):
#		runtime.set_shutdown_hook(_counter_store.shutdown_hook)
		pass

app = webapp2.WSGIApplication([
        ('/_ah/start', StartHandler),
	('/backend/primer/mumu', PrimerHandler)
], debug=True)
