FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apt-get update -qq && apt-get -qy install ca-certificates git build-essential automake libevent-dev libssl-dev linux-libc-dev libgcc-4.9-dev libc6-dev python libpcre3-dev cvs vim less net-tools sudo && apt-get -qy clean
WORKDIR /opt
RUN git clone https://git.torproject.org/tor.git
WORKDIR /opt/tor
RUN useradd -m tor
RUN ./autogen.sh
RUN ./configure --disable-asciidoc --prefix=/usr --with-tor-user=tor --with-tor-group=tor
RUN make
RUN make install 
RUN make distclean
WORKDIR /opt
RUN cvs -d:pserver:anonymous@ijbswa.cvs.sourceforge.net:/cvsroot/ijbswa login
RUN cvs -z3 -d:pserver:anonymous@ijbswa.cvs.sourceforge.net:/cvsroot/ijbswa co current
WORKDIR /opt/current
RUN useradd privoxy
RUN autoheader && autoconf
RUN ./configure --prefix=/usr --disable-toggle --disable-editor --disable-force --with-user=privoxy --with-group=privoxy --sysconfdir=/usr/etc/privoxy
RUN make 
RUN sync 
RUN make install
RUN make distclean
#RUN cp /usr/etc/tor/torrc.sample /usr/etc/tor/torrc && sed -ri 's/^#RunAsDaemon.+/RunAsDaemon 1/g' /usr/etc/tor/torrc && echo "Log notice stdout" >> /usr/etc/tor/torrc && sed -ri 's/^listen-address.+/listen-address\s+0.0.0.0:8118/g' /usr/etc/privoxy/config && sed -ri 's/^#\s+forward-socks5t/forward-socks5t/g' /usr/etc/privoxy/config && sed -ri 's/^P_CONF_FILE=.+/P_CONF_FILE=\/usr\/etc\/privoxy\/config/g' /etc/init.d/privoxy
RUN cp /usr/etc/tor/torrc.sample /usr/etc/tor/torrc && echo "Log notice stdout" >> /usr/etc/tor/torrc && sed -ri 's/^listen-address.+/listen-address 0.0.0.0:8118/g' /usr/etc/privoxy/config && sed -ri 's/^#\s+forward-socks5t/forward-socks5t/g' /usr/etc/privoxy/config && sed -ri 's/^P_CONF_FILE=.+/P_CONF_FILE=\/usr\/etc\/privoxy\/config/g' /etc/init.d/privoxy
EXPOSE 8118
COPY ./start.sh /opt/start.sh
CMD ["/opt/start.sh"]

