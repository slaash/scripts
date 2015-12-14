FROM sander85/rpi-alpine
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

ENV TERM=linux
RUN apk update && apk add openssh-client openvpn dnsmasq
RUN mkdir /dev/net && mknod /dev/net/tun c 10 200 && chmod 666 /dev/net/tun
ADD ./vpn /etc/dnsmasq.d/vpn
ADD ./start.sh /opt/start.sh
VOLUME ["/opt/openvpn"]
WORKDIR "/opt/openvpn"
ENTRYPOINT ["sh","/opt/start.sh"]
