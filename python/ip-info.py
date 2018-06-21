import requests
import sys
import json

req = requests.get('http://ip-api.com/json/{}'.format(sys.argv[1]))
req.raise_for_status()
data = json.loads(req.text)
resp = ""
for k in data.keys():
    if len(str(data[k])) > 0:
        resp = resp + '{}: {}'.format(k, data[k]) + "\n"
print(resp)
