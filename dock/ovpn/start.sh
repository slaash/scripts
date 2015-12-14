#!/bin/bash

sed -ie 's/^#conf-dir=\/etc\/dnsmasq.d$/conf-dir=\/etc\/dnsmasq.d/g' /etc/dnsmasq.conf
dnsmasq
openvpn client.ovpn
