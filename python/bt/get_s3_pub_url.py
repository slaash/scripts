import boto.ec2

conn = boto.connect_s3()
bkt = conn.get_bucket('com.uberresearch.userexporteddata')
key=bkt.new_key('test.txt')
#key.set_acl('public-read')
url = key.generate_url(expires_in=60)
print(url)

