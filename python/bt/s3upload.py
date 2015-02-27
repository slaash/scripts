#!/usr/bin/python

import boto.ec2
from boto.s3.key import Key
import sys
import os.path
import getopt

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

	def split_path(self, fullpath):
		fullpath = os.path.split(fullpath)
		path = os.path.join(*fullpath[:-1])
		name = fullpath[-1]
		return(path, name)

	def get_files(self, dst_prefix, files):
		for f in files:
			new_file = os.path.join(dst_prefix, f)
			new_path = self.split_path(new_file)[0]
			if (os.path.isdir(new_path) == False):
				os.makedirs(new_path)
				print("Created dir " + new_path)
			try:
				key = Key(self.bkt)
				key.key = f
				key.get_contents_to_filename(new_file)
				print("Created file " + new_file)
			except boto.exception.S3ResponseError, err:
				print(err)

	def put_files(self, dst_prefix, files):
		for f in files:
			orig_f = f
			if f.startswith('/'):
				print("Removing leading / from " + f)
				f = f[1:]
			upload_file_dst = os.path.join(dst_prefix, f)
			if (self.bkt.get_key(upload_file_dst) == None):
				new_key = Key(self.bkt)
				new_key.key = upload_file_dst
				new_key.set_contents_from_filename(orig_f)
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

dst = ''
del_file = ''
mode = ''
 
sys.argv.pop(0)
optlist, args = getopt.getopt(sys.argv, 'b:1lpghe:c:s:d:')
for o, a in optlist:
        if o == '-b':
                bkt = a
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
		print("usage: " + __file__ + " <option(s)> <parameter(s)>|<file(s)>" +
"""
-h: help
-b <bucket>: use specified S3 bucket
-1 -l -p -g: operation mode <short list of files|long list of files|put local source file to S3 destination file|get S3 file to local file>
    -d <path>: destination path
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
elif (mode == 'short_list'):
	filez=mys3m.list_files()
	keys=list(filez)
	keys.sort()
	for f in keys:
		print(f)
elif (mode == 'put'):
	if (len(args) != 0 and dst != ''):
		mys3m.put_files(dst, args)
	else:
		print("We need source and destination!")
elif (mode == 'get'):
	if (len(args) != 0 and dst != ''):
		mys3m.get_files(dst, args)
	else:
		print("We need source and destination!")
elif (mode == 'del'):
	mys3m.del_file(del_file)
elif (mode == 'cat'):
	print(mys3m.cat_file(cat_file))
else:
	print ("Mode not specified!")

