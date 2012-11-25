#!/usr/bin/python

import BaseHTTPServer 
import SocketServer
import csv, time, sys, os.path

class CustomHandler(BaseHTTPServer.BaseHTTPRequestHandler):

	server_version = "server"
	sys_version = "system"

	def do_GET(self):
		self.send_response(200)
		self.end_headers()
		outputCSV.writerow((time.strftime('%d-%m-%Y %H:%M:%S'), self.address_string(), self.client_address[0], self.client_address[1], self.command, self.path, self.request_version))
		return

	def do_POST(self):
		self.send_response(200)
                self.end_headers()
		outputCSV.writerow((time.strftime('%d-%m-%Y %H:%M:%S'), self.address_string(), self.client_address[0], self.client_address[1], self.command, self.path, self.request_version))

class thrSimpleHTTPServer(SocketServer.ThreadingMixIn, BaseHTTPServer.HTTPServer):
	pass

PORT = 8000

outputFile = open(os.path.join(sys.path[0],'output.csv'), 'a')
outputCSV = csv.writer(outputFile, delimiter = ',', quotechar = '"', quoting = csv.QUOTE_MINIMAL)

httpd = thrSimpleHTTPServer(("", PORT), CustomHandler)

print("serving at port"+str(PORT))
print("using file "+os.path.join(sys.path[0],'output.csv'))
try:
	httpd.serve_forever()
except KeyboardInterrupt,err:
	print("Got CTRL-C, exiting...\n");

httpd.shutdown()
outputFile.close()
print("Done!\n")

