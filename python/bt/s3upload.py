#!/usr/bin/python

import boto.ec2
from boto.s3.key import Key
import sys
import os.path
import getopt
from string import split

class S3Manager():

	prof_name = 's3-user'
	s3_host = 's3.amazonaws.com'

	def __init__(self, bkt):
		self.conn = boto.connect_s3(profile_name = self.prof_name, host = self.s3_host)
		self.bkt = self.conn.get_bucket(bkt)

	def list_files(self):
		filez=[]
		for k in self.bkt.get_all_keys():
			filez.append(k.name)
		return(filez)

	def get_file(self, down_file_src, down_file_dst):
		key = Key(self.bkt)
		key.key = down_file_src
		key.get_contents_to_filename(down_file_dst)

	def put_file(self, upload_file_src, upload_file_dst):
		new_key = Key(self.bkt)
		if (self.bkt.get_key(upload_file_dst) == None):
			new_key.key = upload_file_dst
			new_key.set_contents_from_filename(upload_file_src)
			print("Created file " + upload_file_dst)
		else:
			raise Exception(upload_file_dst + " already exists!")

src = ''
dst = ''
mode = ''
 
sys.argv.pop(0)
optlist, args = getopt.getopt(sys.argv, 'b:lpghe:s:d:')
for o, a in optlist:
        if o == '-b':
                bkt = a
	if o == '-s':
		src = a
	if o == '-d':
		dst = a
	if o == '-p':
		mode = 'put'
	if o == '-g':
		mode = 'get'
	if o == '-l':
		mode = 'list'
	if o == '-e':
		mode = 'del'
	if o == '-h':
		print("usage: " + __file__ + " <option(s)> <parameter(s)>" +
"""
-h: help
-b <bucket>: use specified S3 bucket
-l -p -g: operation mode <list files|put local source file to S3 destination file|get S3 file to local file>
    -s <file>: source file
    -d <file>: destination file
-e <file>: delete file
""")
		sys.exit(0)

mys3m = S3Manager(bkt)

if (mode == 'list'):
	for f in  mys3m.list_files():
		print(f)
elif (mode == 'put'):
	if (src != '' and dst != ''):
		mys3m.put_file(src, dst)
	else:
		print("We need source and destination!")
elif (mode == 'get'):
	if (src != '' and dst != ''):
		mys3m.get_file(src, dst)
	else:
		print("We need source and destination!")
elif (mode == 'del'):
	pass
else:
	print ("Mode not specified!")

