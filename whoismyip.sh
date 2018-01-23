#/bin/bash

curl -s http://freegeoip.net/csv/|cut -d ',' -f 1|xargs -i -t whois {} |grep "descr"
curl -4s http://freegeoip.net/csv/|cut -d ',' -f 1|xargs -i -t whois {} |grep "descr"
