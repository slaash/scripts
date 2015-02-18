#!/usr/bin/python

import boto.ec2

iam = boto.connect_iam()
user = iam.get_user()
print("Running as {} ({})".format(user.user_name, user.user_id))

conn = boto.ec2.connect_to_region("eu-central-1")
reservations = conn.get_all_instances()
for r in reservations:
	for i in r.instances:
		print(i.id, i.public_dns_name, i.instance_type, i.launch_time, i.state, i.virtualization_type, i.architecture, i.image_id)

