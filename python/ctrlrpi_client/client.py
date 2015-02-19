#!/usr/bin/python

import os
import json
import cookielib
import urllib2
import urllib

creds_file = os.path.join(os.environ['HOME'], 'creds.json')
json_data = open(creds_file)
creds = json.load(json_data)
json_data.close()
user = creds['user']
passw = creds['pass']

target_uri = 'http://ctrlrpi.appspot.com'
app_name = 'ctrlrpi'

cookiejar = cookielib.LWPCookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookiejar))
urllib2.install_opener(opener)

auth_uri = 'https://www.google.com/accounts/ClientLogin'
authreq_data = urllib.urlencode({ "Email":   user,
                                  "Passwd":  passw,
                                  "service": "ah",
                                  "source":  app_name,
                                  "accountType": "HOSTED_OR_GOOGLE" })
auth_req = urllib2.Request(auth_uri, data=authreq_data)
auth_resp = urllib2.urlopen(auth_req)
auth_resp_body = auth_resp.read()
# auth response includes several fields - we're interested in 
#  the bit after Auth= 
auth_resp_dict = dict(x.split("=")
                      for x in auth_resp_body.split("\n") if x)
authtoken = auth_resp_dict["Auth"]
print(authtoken)

serv_uri = target_uri

serv_args = {}
serv_args['continue'] = serv_uri
serv_args['auth']     = authtoken

full_serv_uri = "http://ctrlrpi.appspot.com/_ah/login?%s" % (urllib.urlencode(serv_args))

serv_req = urllib2.Request(full_serv_uri)
serv_resp = urllib2.urlopen(serv_req)
serv_resp_body = serv_resp.read()

req = urllib2.Request("http://ctrlrpi.appspot.com/record/5649391675244544")
contents = urllib2.urlopen(req).read()
print(contents)
