#!/bin/sh

iptables -F
iptables -P INPUT DROP

#dropuim pachetele invalide de pe orice interfata
iptables -A INPUT -m state --state INVALID -j ULOG --ulog-prefix "INVALID"
iptables -A INPUT -m state --state INVALID -j DROP

#acceptam conexiuni deja formate
iptables -A INPUT -i eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
#acceptam conexiuni pe diverse porturi/protocoale
#iptables -A INPUT -i eth0 -p TCP --dport 21 -j ACCEPT #FTP
iptables -A INPUT -i eth0 -p TCP --dport 22 -j ACCEPT #SSH
iptables -A INPUT -i eth0 -p TCP --dport 80 -j ACCEPT #WEB
#iptables -A INPUT -i eth0 -p TCP --dport 1241 -j ACCEPT #NESSUS
#iptables -A INPUT -i eth0 -p TCP --dport 3306 -j ACCEPT #MYSQL
iptables -A INPUT -i eth0 -p TCP --dport 5900 -j ACCEPT #VNC :0
iptables -A INPUT -i eth0 -p TCP --dport 5901 -j ACCEPT #VNC :1
iptables -A INPUT -i eth0 -p TCP --dport 139 -j ACCEPT #SAMBA
iptables -A INPUT -i eth0 -p TCP --dport 445 -j ACCEPT #SAMBA
iptables -A INPUT -i eth0 -p TCP --dport 8001 -j ACCEPT #SAMBA
#iptables -A INPUT -i eth0 -p TCP --dport 7070 -j ACCEPT #HPTTPD
#iptables -A INPUT -i eth0 -p TCP --dport 8180 -j ACCEPT #TOMCAT
#iptables -A INPUT -i eth0 -p TCP --dport 8080 -j ACCEPT #SQUID
#iptables -A INPUT -i eth0 -p TCP --dport 8888 -j ACCEPT #NETSED
#iptables -A INPUT -i eth0 -p TCP --dport 55555 -j ACCEPT #METASPLOIT
iptables -A INPUT -i eth0 -p UDP --dport 137 -j ACCEPT #SAMBA
iptables -A INPUT -i eth0 -p UDP --dport 138 -j ACCEPT #SAMBA
iptables -A INPUT -i eth0 -p UDP --dport 1194 -j ACCEPT #OPENVPN
iptables -A INPUT -i eth0 -p UDP --dport 514 -j ACCEPT #SYSLOG-NG
iptables -A INPUT -i eth0 -p ICMP -j ACCEPT
#logam pachetele care nu au fost acceptate deja pt. TCP si UDP
iptables -A INPUT -i eth0 -p TCP -j ULOG --ulog-prefix "TCP_DROP";
iptables -A INPUT -i eth0 -p UDP -j ULOG --ulog-prefix "UDP_DROP";
#dropuim ce nu a fost acceptat pana acum
iptables -A INPUT -i eth0 -m state --state NEW -j DROP

#acceptam conexiuni de pe lo si tun0
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i tun0 -j ACCEPT
