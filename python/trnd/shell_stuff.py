#!/usr/bin/python3

import tornado.ioloop
import tornado.web
import tornado.escape
import subprocess

class BaseHandler(tornado.web.RequestHandler):

	def _print(self,txt):
		self._txt=tornado.escape.xhtml_escape(txt)
		self._txt=txt
		self.write(self._txt)
		self._br()

	def _hr(self):
		self.write('<hr/>'+"\n")

	def _br(self):
		self.write('<br/>'+"\n")

	def _h1(self,txt):
		self._txt=tornado.escape.xhtml_escape(txt)
		self.write("<h1>{}</h1>".format(self._txt))
		self._br()

class MainHandler(BaseHandler):
	def get(self):
		self._h1("Hello, world!<input type='submit' value='run'>")
		self._print("Hello, world!<input type='submit' value='run'>")

class ProcHandler(BaseHandler):
	def get(self):
		if ("cmd" in self.request.arguments):
			cmd=self.request.arguments["cmd"][0].decode("utf-8")#byte str to unicode str
			self._print(cmd)
			self._hr()
			self.runCmd(cmd.split(' '))
			self._hr()

	def runCmd(self,cmd):
		p=subprocess.Popen(cmd,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
		for line in iter(p.stdout.readline,""):
			self._print(line.rstrip())

application = tornado.web.Application([
	(r"/", MainHandler),
	(r"/ps", ProcHandler),
])

if __name__ == "__main__":
	application.listen(8888)
	tornado.ioloop.IOLoop.instance().start()

