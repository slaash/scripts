#!/usr/bin/env python

import cgi
import json

import webapp2

from google.appengine.ext import db
from google.appengine.api import runtime

class PrimerInfo(db.Model):
        date = db.DateTimeProperty(auto_now_add=True)
        de_la = db.StringProperty()
        la = db.StringProperty()
        numbers = db.StringProperty()

class PrimerHandler(webapp2.RequestHandler):
	def setPrimerInfo(self,de_la,la,numbers):
		pr=PrimerInfo()
		pr.de_la=de_la
		pr.la=la
		pr.numbers=numbers
		pr.put()

	def get(self):
		self.response.out.write("hello from backend!")
		self.setPrimerInfo('111','222','get 113,115,117,...')

	def post(self):
		self.response.out.write("hello from backend!")
		self.setPrimerInfo('111','222','post 113,115,117,...')

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
