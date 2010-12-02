#!/bin/sh

iptables -F
iptables -P INPUT ACCEPT
iptables -P INPUT DROP

iptables -A INPUT -m state --state INVALID -j DROP
iptables -A INPUT -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i tun0 -j ACCEPT
