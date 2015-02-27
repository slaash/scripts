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
		filez={}
		for k in self.bkt.get_all_keys():
			filez[k.name]=k.size
		return(filez)

	def bucket_size(self):
		size=0.00
		for k in self.bkt.get_all_keys():
			size+=k.size
		return(size)

	def get_file(self, down_file_src, down_file_dst):
		key = Key(self.bkt)
		key.key = down_file_src
		fullpath=split(down_file_dst, '/')
		path=fullpath[:-1]
		realpath=os.path.join('/',*path)
		if (os.path.isdir(realpath) == False):
			os.makedirs(realpath)
		try:
			key.get_contents_to_filename(down_file_dst)
			print("Created file " + down_file_dst)
		except boto.exception.S3ResponseError, err:
			print(err)

	def put_file(self, upload_file_src, upload_file_dst):
		new_key = Key(self.bkt)
		if (self.bkt.get_key(upload_file_dst) == None):
			new_key.key = upload_file_dst
			new_key.set_contents_from_filename(upload_file_src)
			print("Created file " + upload_file_dst)
		else:
			raise Exception(upload_file_dst + " already exists!")

	def cat_file(self, cat_file):
		key = Key(self.bkt)
		key.key = cat_file
		return(key.get_contents_as_string())

	def del_file(self, del_file):
		key = Key(self.bkt)
		key.key = del_file
		if (self.bkt.get_key(del_file) != None):
			self.bkt.delete_key(key)
			print("Deleted file " + del_file)
		else:
			print("File not found: " + del_file)

src = ''
dst = ''
del_file = ''
mode = ''
 
sys.argv.pop(0)
optlist, args = getopt.getopt(sys.argv, 'b:1lpghe:c:s:d:')
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
	if o == '-1':
		mode = 'short_list'
	if o == '-l':
		mode = 'list'
	if o == '-e':
		mode = 'del'
		del_file = a
	if o == '-c':
		mode = 'cat'
		cat_file = a
	if o == '-h':
		print("usage: " + __file__ + " <option(s)> <parameter(s)>" +
"""
-h: help
-b <bucket>: use specified S3 bucket
-1 -l -p -g: operation mode <short list of files|long list of files|put local source file to S3 destination file|get S3 file to local file>
    -s <file>: source file
    -d <file>: destination file
-e <file>: delete file
-c <file>: cat file
""")
		sys.exit(0)

mys3m = S3Manager(bkt)

if (mode == 'list'):
	filez=mys3m.list_files()
	keys=list(filez)
	keys.sort()
	for f in keys:
		print("{} {} bytes".format(f, filez[f]))
	print("")
	print("Bucket size: {0:.2f} MB".format(mys3m.bucket_size()/1024/1024))
if (mode == 'short_list'):
	filez=mys3m.list_files()
	keys=list(filez)
	keys.sort()
	for f in keys:
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
	mys3m.del_file(del_file)
elif (mode == 'cat'):
	print(mys3m.cat_file(cat_file))
else:
	print ("Mode not specified!")

