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
import webapp2
from google.appengine.api import users
import os,time
import platform as pl
import cgi
import json

class BaseHandler(webapp2.RequestHandler):
	def _print(self,txt):
		self.response.out.write(txt)
		self._br()

	def _hr(self):
		self.response.out.write('<hr/>'+"\n")

	def _br(self):
		self.response.out.write('<br/>'+"\n")

class MainHandler(BaseHandler):
	def get(self):
		user = users.get_current_user()
		if (user):
			now=time.ctime(time.time())
			self._print('{} - Hello {} ({}) !'.format(now,user.nickname(),user.email()))
			self._hr()
			self._print("Your IP: "+self.request.remote_addr)
			self._print("Origin URL: "+self.request.url)
			self._print("uid: "+str(os.getuid()))
			self._print("pid: "+str(os.getpid()))
			self._print("cwd: "+os.getcwd())
			self._print(pl.system()+", "+pl.architecture()[0])
			self._print(pl.python_implementation()+", "+pl.python_version())
			self._hr()
			self._form("/primez","de la","la")
			self._hr()
			self.response.out.write("<a href='/logoff'>LogOut_1</a>")
			self._br()	
			self.response.out.write("<a href='"+users.create_logout_url("/")+"'>LogOut_2</a>")
		else:
			self.redirect(users.create_login_url(self.request.uri))

	def _form(self,*args):
		url=args[0]
		self._print('<form action="'+url+'" method="POST">')
		self._print('<select name="qtype" size="2">')
		self._print('<option value="HTML" selected="selected">HTML</option>')
		self._print('<option value="JSON">JSON</option>')
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
			self._print(cgi.escape(self.request.get('de la')))
			self._print(cgi.escape(self.request.get('la')))
		elif (qtype=='JSON'):
			d={}
			d['de la']=cgi.escape(self.request.get('de la'))
			d['la']=cgi.escape(self.request.get('la'))
			self.response.out.write(json.dumps(d))

app = webapp2.WSGIApplication([
	('/', MainHandler),
	('/logoff', LogoffHandler),
	('/primez', PrimezHandler)
], debug=True)
