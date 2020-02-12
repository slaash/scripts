FROM debian:testing

RUN apt -q update && apt -qy upgrade && apt -qy install libcairo2-dev libjpeg62-turbo-dev libpng-dev libossp-uuid-dev libavcodec-dev libavutil-dev libswscale-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libpulse-dev libssl-dev libvorbis-dev libwebp-dev wget maven jetty9 x11vnc build-essential && apt -q clean

WORKDIR /tmp
RUN wget -q https://github.com/apache/guacamole-client/archive/1.0.0.tar.gz -O guacamole-client-1.0.0.tar.gz && wget -q https://github.com/apache/guacamole-server/archive/1.0.0.tar.gz -O guacamole-server-1.0.0.tar.gz
#RUN tar -xzf guacamole-server-0.9.14.tar.gz && cd guacamole-server-0.9.14 && ./configure --with-init-dir=/etc/init.d && make && make install && update-rc.d guacd defaults && ldconfig
#RUN tar -xzf guacamole-client-0.9.14.tar.gz && cd guacamole-client-0.9.14 && mvn package
#
#RUN cp guacamole/target/guacamole-0.9.14.war /var/lib/jetty9/webapps/guacamole.war && mkdir -p /etc/guacamole/extensions && cp extensions/guacamole-auth-noauth/target/guacamole-auth-noauth-0.9.14.jar /etc/guacamole/extensions/
#
#COPY guacamole.properties /etc/guacamole/guacamole.properties
#COPY noauth-config.xml /etc/guacamole/noauth-config.xml
#COPY user-mapping.xml /etc/guacamole/user-mapping.xml
#COPY x11vnc.desktop /root/.config/autostart/x11vnc.desktop
