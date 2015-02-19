#!/usr/bin/env python

#$ curl -X POST --data "one two three four" localhost:8080/store.json
#$ curl -X GET localhost:8080/store.json    
#one two three four%

#curl -i -F name=test -F filedata=@localfile.jpg http://example.org/upload

from os import curdir
from os.path import join as pjoin

from SimpleHTTPServer import SimpleHTTPRequestHandler
import SocketServer
import urlparse

class StoreHandler(SimpleHTTPRequestHandler):
	store_path = pjoin(curdir, 'store.json')
	def do_GET(self):
		if self.path == '/store.json':
			with open(self.store_path) as fh:
				self.send_response(200)
				self.send_header('Content-type', 'text/json')
				self.end_headers()
				self.wfile.write(fh.read().encode())
	def do_POST(self):
		if self.path == '/store.json':
			length = self.headers['content-length']
			data = self.rfile.read(int(length))
			print(data)
			post_data = urlparse.parse_qs(data)
			print(post_data)

#            with open(self.store_path, 'w') as fh:
#                fh.write(data.decode())

			self.send_response(200)

server = SocketServer.TCPServer(("", 8080), StoreHandler)
print("Server started on port 8080.")
server.serve_forever()

