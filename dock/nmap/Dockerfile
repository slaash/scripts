FROM sdhibit/rpi-raspbian:latest

RUN apt-get update -qq && apt-get -qy install subversion g++ libpcre3-dev libssl-dev liblua5.2-dev libpcap-dev libsvn-dev liblinear-dev linux-headers-rpi2-rpfv python2.7 make autoconf && apt-get -qy clean
WORKDIR /opt
RUN svn --non-interactive --trust-server-cert co https://svn.nmap.org/nmap
WORKDIR /opt/nmap
RUN ./configure --prefix=/usr --without-ncat
RUN make && make install

