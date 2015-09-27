FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install ca-certificates subversion g++ libpcre3-dev libssl-dev liblua5.2-dev libpcap-dev libsvn-dev liblinear-dev linux-headers-rpi2-rpfv python2.7 make autoconf && apt-get -qy clean
WORKDIR /opt
RUN svn --non-interactive co https://svn.nmap.org/nmap
WORKDIR /opt/nmap
RUN svn --non-interactive up && ./configure --prefix=/usr --without-ncat && make && make install && make clean
WORKDIR /
