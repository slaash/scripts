#/bin/bash

curl -s 'http://api.ipstack.com/89.238.244.126?access_key=18d7fb844058a5a95b84e2f6c6e8d2b0&format=1'|jq -r '.ip'|xargs -i -t whois {} |grep "descr"
curl -4s 'http://api.ipstack.com/89.238.244.126?access_key=18d7fb844058a5a95b84e2f6c6e8d2b0&format=1'|jq -r '.ip'|xargs -i -t whois {} |grep "descr"
