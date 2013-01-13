#!/usr/bin/env python
#
# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
import os
import time
import platform as pl
import cgi
import json
import urllib
import logging

import webapp2

from google.appengine.api import users, backends, taskqueue, runtime, files
from google.appengine.ext import db

import db_models

class BaseHandler(webapp2.RequestHandler):

	def __init__(self, request, response):
		self.initialize(request, response)
		self.user = users.get_current_user()

	def dispatch(self):
		if (self.user):
			super(BaseHandler, self).dispatch()
		else:
			self.redirect(users.create_login_url(self.request.uri))

	def _print(self,txt):
		self.response.out.write(txt)
		self._br()

	def _hr(self):
		self.response.out.write('<hr/>'+"\n")

	def _br(self):
		self.response.out.write('<br/>'+"\n")

class MainHandler(BaseHandler):

	def setVisInfo(self,ip,nick,email):
		vis=db_models.VisitorInfo()
		vis.ip=ip
		vis.nick=nick
		vis.email=email
		logging.info("{} {} {}".format(ip,nick,email))
		vis.put()

	def get(self):
		self.setVisInfo(self.request.remote_addr,self.user.nickname(),self.user.email())
		now=time.ctime(time.time())
		self._print('{} - Hello {} ({}) !'.format(now,self.user.nickname(),self.user.email()))
		self._hr()
		self._print("Your IP: "+self.request.remote_addr)
		self._print("Origin URL: "+self.request.url)
		self._print("uid: "+str(os.getuid()))
		self._print("pid: "+str(os.getpid()))
		self._print("cwd: "+os.getcwd())
		self._print(pl.system()+", "+pl.architecture()[0])
		self._print(pl.python_implementation()+", "+pl.python_version())
		self._print("Used mem: "+str(runtime.memory_usage().current())+" MB")
		self._print("Used mem last min: "+str(runtime.memory_usage().average1m())+" MB")
		self._print("CPU usage: "+str(runtime.cpu_usage().total())+" Mcycles")
		self._print("CPU usage last min: "+str(runtime.cpu_usage().rate1m())+" Mcycles")
		self._hr()
		self._form("/primez","de_la","la")
		self._hr()
		self.response.out.write("<a href='"+backends.get_url('primer')+"/backend/primer/mumu'>Primer</a>")
		self._hr()
		self.response.out.write("<a href='/logoff'>LogOut_1</a>")
		self._br()	
		self.response.out.write("<a href='"+users.create_logout_url("/")+"'>LogOut_2</a>")

	def _form(self,*args):
		url=args[0]
		self._print('<form action="'+url+'" method="POST">')
		self._print('<select name="qtype" size="2">')
		self._print('<option value="HTML">HTML</option>')
		self._print('<option value="JSON">JSON</option>')
		self._print('<option value="Backend" selected="selected">Backend</option>')
		self._print('</select>')
		for a in args[1:]:
			self._print(a+' <input type="text" name="'+a+'">')
		self._print('<input type="submit" value="Run">')
		self._print('</form>')

class LogoffHandler(BaseHandler):
	def get(self):
		self.redirect(users.create_logout_url("/"))

class PrimezHandler(BaseHandler):
	def post(self):
		qtype=cgi.escape(self.request.get('qtype'))
		if (qtype=='HTML'):
			self._print(cgi.escape(self.request.get('de_la')))
			self._print(cgi.escape(self.request.get('la')))
		elif (qtype=='JSON'):
			d={}
			d['de_la']=cgi.escape(self.request.get('de_la'))
			d['la']=cgi.escape(self.request.get('la'))
			self.response.out.write(json.dumps(d))
		elif (qtype=='Backend'):
			payload = urllib.urlencode({'de_la': cgi.escape(self.request.get('de_la')), 'la':cgi.escape(self.request.get('la'))})
			url = backends.get_url('primer') + '/backend/primer/mumu'
			self._print("Backend at "+url)
#			urlfetch.fetch(url, method='POST', payload=payload) # timesout
			q=taskqueue.Queue('MyQueue')
			q.purge()
			taskqueue.add(queue_name='MyQueue', url='/backend/primer/mumu',params=dict(de_la=cgi.escape(self.request.get('de_la')), la=cgi.escape(self.request.get('la')), transactional=False))
			qstats=q.fetch_statistics()
			self._print("{}: {} out of {} running tasks".format(qstats.queue,qstats.in_flight,qstats.tasks))
			self._print("Done!")
#			self._print(result.content.strip())

	def get(self):
		self.post()

class dropTable(BaseHandler):

	def get(self):
		taskqueue.add(queue_name='default', url='/backend/primer/drop')
		self._print("Done!")

class purgeQueue(BaseHandler):

	def get(self):
		q=taskqueue.Queue('MyQueue')
		qstats=q.fetch_statistics()
		self._print("Before - {}: {} out of {} running tasks".format(qstats.queue,qstats.in_flight,qstats.tasks))
		q.purge()
		qstats=q.fetch_statistics()
		self._print("After - {}: {} out of {} running tasks".format(qstats.queue,qstats.in_flight,qstats.tasks))
		self._print("Done!")

class VisitorsHandler(BaseHandler):
	def get(self):
		rez=db.GqlQuery("select * from VisitorInfo order by date desc")
		for line in rez:
			self._print("{} | {} | {} | {}".format(line.date,line.ip,line.nick,line.email))
			self._hr()

class ShowPrimezHandler(BaseHandler):
	def get(self):
		rez=db.GqlQuery("select * from PrimerInfo order by date desc")
		for line in rez:
			self._print("{} | {} | {} | {} | {} | {}".format(line.date,line.duration,line.stats,line.de_la,line.la,line.numbers))
			self._hr()

class FilezHandler(BaseHandler):
	def get(self):
		items=files.listdir('/gs/mybucket')
		if (len(items)==0):
			self._print("No filez!")
			my_file='/gs/mybucket/readme.txt'
			files.gs.create(my_file)
			f=files.open(my_file,'a')
			f.write('Hello world!')
			f.close()
		else:
			for i in items:
				self._print(i)

app = webapp2.WSGIApplication([
	('/', MainHandler),
	('/logoff', LogoffHandler),
	('/primez', PrimezHandler),
	('/doctor/who', VisitorsHandler),
	('/got/primez', ShowPrimezHandler),
	('/drop/table', dropTable),
	('/purge/queue', purgeQueue),
	('/filez', FilezHandler)
], debug=True)
