#/bin/bash

curl -s http://freegeoip.net/csv/|cut -d ',' -f 1|xargs -i -t whois {} |grep "descr"

