#!/usr/bin/python

import BaseHTTPServer 
import SocketServer
import threading
import cgi

class CustomHandler(BaseHTTPServer.BaseHTTPRequestHandler):

	server_version="server"
	sys_version="system"

	def do_GET(self):
		self.send_response(200)
		self.end_headers()
		thrName = threading.currentThread().getName()
		msg=self.server_version+" "+self.sys_version+"\n"+thrName+"\n"+"Hello "+self.address_string()+"("+self.client_address[0]+"):"+str(self.client_address[1])+"!\n"+self.command+" "+self.path+" "+self.request_version+"\n"
		print(msg)
#		self.wfile.write(msg)
		return


	def do_POST(self):
		self.send_response(200)
                self.end_headers()




class thrSimpleHTTPServer(SocketServer.ThreadingMixIn,BaseHTTPServer.HTTPServer):
	pass

PORT = 8000

httpd=thrSimpleHTTPServer(("",PORT),CustomHandler)

print "serving at port", PORT
httpd.serve_forever()

