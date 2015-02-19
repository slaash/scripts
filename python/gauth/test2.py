#!/usr/bin/python

from oauth2client.client import SignedJwtAssertionCredentials
import json
import urllib
import urllib2

# Settings
json_key_file = '/home/pi/google_key/client_secrets.json'

# Load the private key associated with the Google service account
with open(json_key_file) as json_file:
    json_data = json.load(json_file)

# Get and sign JWT
credential = SignedJwtAssertionCredentials(json_data['client_email'], json_data['private_key'], 'https://www.googleapis.com/auth/devstorage.read_write')
jwt_complete = credential._generate_assertion()

# Get token from server
data = {'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer', 
    'assertion': jwt_complete}
f = urllib2.urlopen("https://accounts.google.com/o/oauth2/token", urllib.urlencode(data))

print f.read()

f = urllib2.urlopen("https://ctrlrpi.appspot.com")
print f.read()

