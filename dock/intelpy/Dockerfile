FROM ubuntu

COPY ./pythoni-3.5.20150803_185146/* /opt/pythoni-3.5.20150803_185146/
WORKDIR /opt/pythoni-3.5.20150803_185146
RUN ./install.sh -y -i /usr && rm -rf /opt/pythoni-3.5.20150803_185146 && ln -s /usr/bin/python3 /usr/bin/python

