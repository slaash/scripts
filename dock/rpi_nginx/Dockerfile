FROM sdhibit/rpi-raspbian:latest

#COPY ./nginx-stable-trusty.list /etc/apt/sources.list.d/nginx-stable-trusty.list
#COPY ./docker.list /etc/apt/sources.list.d/docker.list
#RUN chmod 644 /etc/apt/sources.list.d/docker.list
#RUN chmod 644 /etc/apt/sources.list.d/nginx-stable-trusty.list

#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C407E17D5F76A32B 00A6F0A3C300EE8C 36A1D7869245C8950F966E92D8576A8BA88D21E9
#RUN apt-get -qy install apt-transport-https bash-completion
RUN apt-get update -qq
#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN ln -s /bin/true /sbin/initctl
#RUN touch /etc/init.d/cgroup-lite
#RUN apt-get -qy install lxc-docker nginx-extras
RUN apt-get -qy install nginx-extras ca-certificates
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
#VOLUME ["/var/cache/nginx"]
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
#CMD /etc/init.d/nginx start


