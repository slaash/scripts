#!/usr/bin/python

import boto.ec2
import sys

prof_name=''

if (len(sys.argv)==2):
	prof_name = sys.argv[1]
	print("Using profile " + prof_name)
else:
	print("Usage: "+sys.argv[0]+" <profile>")
	sys.exit()

iam = boto.connect_iam(profile_name = prof_name)
try:
	user = iam.get_user()
except boto.exception.BotoServerError, err:
	print(err)
else:
	try:
		print("Running as {} ({})".format(user.user_name, user.user_id))
	except AttributeError, err:
		print(err)
	print("AWS_ACCESS_KEY: {}\nAWS_SECRET_KEY: {}".format(iam.access_key, iam.secret_key))
	pass

for reg in boto.ec2.regions():
	print(reg.name)
	conn = boto.ec2.connect_to_region(reg.name, profile_name = prof_name)
	try:
		reservations = conn.get_all_instances()
	except boto.exception.EC2ResponseError, err:
		print(err)
	else:
		for r in reservations:
			for i in r.instances:
				print(i.id, i.public_dns_name, i.instance_type, i.launch_time, i.state, i.virtualization_type, i.architecture, i.image_id)

