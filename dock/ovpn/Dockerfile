FROM sdhibit/rpi-raspbian:latest
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

ENV TERM=linux
RUN apt-get update -qq && apt-get -qy install openssh-client openvpn dnsmasq && apt-get -qy clean
RUN mkdir /dev/net && mknod /dev/net/tun c 10 200 && chmod 666 /dev/net/tun
ADD ./vpn /etc/dnsmasq.d/vpn
ADD ./start.sh /opt/start.sh
VOLUME ["/opt/openvpn"]
WORKDIR "/opt/openvpn"
ENTRYPOINT ["/opt/start.sh"]
