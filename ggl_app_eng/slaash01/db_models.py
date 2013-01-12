#!/usr/bin/python

import webapp2

from google.appengine.ext import db

class VisitorInfo(db.Model):
	date = db.DateTimeProperty(auto_now_add=True)
	ip = db.StringProperty()
	nick = db.StringProperty()
	email = db.StringProperty()

class PrimerInfo(db.Model):
	date = db.DateTimeProperty(auto_now_add=True)
	de_la = db.StringProperty()
	la = db.StringProperty()
	numbers = db.StringProperty()
	duration = db.StringProperty()
	stats = db.StringProperty()

