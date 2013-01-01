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

class MainHandler(webapp2.RequestHandler):
	def get(self):
		user = users.get_current_user()
		if (user):
			now=time.ctime(time.time())
			self._print('{} - Hello {} ({}) !'.format(now,user.nickname(),user.email()))
			self._print("uid: "+str(os.getuid()))
			self._print("pid: "+str(os.getpid()))
			self._print("cwd: "+os.getcwd())
			self._print(pl.system()+", "+pl.architecture()[0])
#			self._print(os.uname())
#			self._print(pl.machine())
#			self._print(pl.node())
#			self._print(pl.processor())
			self._print(pl.python_implementation()+", "+pl.python_version())
#			self._print(pl.release())
#			self._print(pl.system())
#			self._print(pl.uname())
#			self._print(pl.version())
#			self._print(pl.linux_distribution())
		else:
			self.redirect(users.create_login_url(self.request.uri))

	def _print(self,txt):
		self.response.out.write(txt)
		self.response.out.write('<br/>'+"\n")

app = webapp2.WSGIApplication([
    ('/', MainHandler)
], debug=True)
