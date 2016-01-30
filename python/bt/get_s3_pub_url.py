import boto.ec2

conn = boto.connect_s3(profile_name='UserExportedData')
bkt = conn.get_bucket('com.uberresearch.userexporteddata')
key=bkt.new_key('ef38785af5af0de266c9972df32ddcbb/piotr@uberresearch.com-Dimensions-project-2016-01-19.csv')
key.set_acl('public-read')
url = key.generate_url(expires_in=3600, query_auth=False)
print(url)

