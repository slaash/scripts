FROM sander85/rpi-alpine
MAINTAINER Radu Moisa <rmoisa@yahoo.com>

RUN apk update && apk upgrade
RUN apk add bash bash-completion nmap curl nikto openssh-client python3 perl mc file python py-pip

RUN adduser -u 1000 -D slash
USER slash

ENTRYPOINT ["/bin/bash"]
