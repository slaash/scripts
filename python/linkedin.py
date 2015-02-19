#!/usr/bin/python

import oauth2 as oauth
import httplib2
import time, os, simplejson as json
from types import *

def printItem(item):
	if (type(item)==ListType):
		for i in item:
			printItem(i)
	elif (type(item)==DictType):
		for i in item.keys():
			printItem(i)
			printItem(item[i])
	else:
		try:
			print(item)
		except UnicodeEncodeError,err:
			print(err)

urls={#'user_prof' : 'http://api.linkedin.com/v1/people/~',
#	'conns' : 'http://api.linkedin.com/v1/people/~/connections'
	'updates' : 'http://api.linkedin.com/v1/people/~/network/updates'
}
 
# Fill the keys and secrets you retrieved after registering your app
consumer_key      =   'zeah1srfpllc'
consumer_secret  =   'kNhQGi1Clm1yRF8t'
user_token           =   '4d2b5bbe-107a-424e-9e97-23ea78d7b5c5'
user_secret          =   '84bfdc05-5c69-4039-b3c4-64a7845e8e0e'
 
# Use your API key and secret to instantiate consumer object
consumer = oauth.Consumer(consumer_key, consumer_secret)
 
# Use your developer token and secret to instantiate access token object
access_token = oauth.Token(
            key=user_token,
            secret=user_secret)
 
client = oauth.Client(consumer, access_token)
 
# Make call to LinkedIn to retrieve your own profile
#resp,content = client.request("http://api.linkedin.com/v1/people/~", "GET", {})
 
# By default, the LinkedIn API responses are in XML format. If you prefer JSON, simply specify the format in your call
for comm in urls.keys():
	resp,content = client.request(urls[comm]+"?format=json", "GET")
	d=json.loads(content)
	for item in d.keys():
#		print(type(d[item]))
#		print("{} => {}".format(item,d[item]))
		printItem(item)
		printItem(d[item])
	
