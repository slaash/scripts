FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install ca-certificates git build-essential automake libevent-dev libssl-dev linux-libc-dev libgcc-4.9-dev libc6-dev python libpcre3-dev cvs && apt-get -qy clean
WORKDIR /opt
RUN git clone https://git.torproject.org/tor.git
WORKDIR /opt/tor
RUN useradd tor
RUN ./autogen.sh
RUN ./configure --disable-asciidoc --prefix=/usr --with-tor-user=tor --with-tor-group=tor
RUN make && make install && make distclean
WORKDIR /opt
RUN cvs -d:pserver:anonymous@ijbswa.cvs.sourceforge.net:/cvsroot/ijbswa login
RUN cvs -z3 -d:pserver:anonymous@ijbswa.cvs.sourceforge.net:/cvsroot/ijbswa co current
WORKDIR /opt/current
RUN useradd privoxy
RUN autoheader && autoconf
RUN ./configure --prefix=/usr --disable-toggle --disable-editor --disable-force --with-user=privoxy --with-group=privoxy
RUN make && make install && make distclean

