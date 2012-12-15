#!/usr/bin/python

import oauth2 as oauth
import httplib2
import time, os, simplejson as json
import pprint

pp = pprint.PrettyPrinter(indent=1)

def getJsonResp(client,url):
	resp,content = client.request(url+"?format=json", "GET")
	d=json.loads(content)
	return(d)

def showJsonUpdates(client):
	d=getJsonResp(client,urls['updates'])
	for value in d['values']:
		uC=value['updateContent']
		if ('person' in uC.keys()):
			print("{} {}\n{}".format(uC['person']['firstName'],uC['person']['lastName'],uC['person']['headline']))
		elif ('company' in uC.keys()):
			print("Company...")
			print("{}".format(uC['company']['name']))
		else:
			print("!!! UNKNOWN CASE !!!")
		pp.pprint(uC)
#		fN=value['updateContent']['person']['firstName']
#		lN=value['updateContent']['person']['lastName']
#		hL=value['updateContent']['person']['headline']
#		print("{} {}".format(fN,lN))
#		print(hL)
#		pp.pprint(getJsonResp(client,value['updateContent']['person']['apiStandardProfileRequest']['url']))
#		pp.pprint(getJsonResp(client,value['updateContent']['person']['currentStatus']))
#		print(value['updateContent']['person']['apiStandardProfileRequest']['currentStatus'])

def getJsonUserProf(client):
        resp,content = client.request(urls['user_prof']+"?format=json", "GET")
        d=json.loads(content)
	return(d)

def getJsonConns(client):
	resp,content = client.request(urls['conns']+"?format=json", "GET")
	d=json.loads(content)
	return(d)	

urls={'user_prof' : 'http://api.linkedin.com/v1/people/~',
	'conns' : 'http://api.linkedin.com/v1/people/~/connections',
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

#pp.pprint(getJsonResp(client,urls['updates']))
showJsonUpdates(client)

