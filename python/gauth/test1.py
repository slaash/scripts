#!/usr/bin/python

from oauth2client.client import flow_from_clientsecrets

flow = flow_from_clientsecrets('/home/pi/google_key/client_secrets.json', scope='https://www.googleapis.com/auth/devstorage.read_write', redirect_uri='http://example.net:80')
auth_uri = flow.step1_get_authorize_url()
print(auth_uri)

