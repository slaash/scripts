#!/usr/bin/python

import mod_python

def index(req):
	form = mod_python.util.FieldStorage(req,keep_blank_values=1)
	user = form.get("user",None)
	req.content_type = "text/plain"
	req.send_http_header()
	req.write("user=%s\n" % user)
	return mod_python.apache.OK

def hello(req):
	return("hello!")

