# This shows systemd services running in a centos7 container.
# There have been lots of problems and workarounds for this, see:
# https://hub.docker.com/_/centos/
# https://github.com/docker/docker/issues/7459
FROM centos:centos7
MAINTAINER "Giles Gamon" <giles.gamon@metoffice.gov.uk>
ENV container=docker

RUN yum install -y epel-release # for nginx
RUN yum install -y initscripts  # for old "service"

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
	systemd-tmpfiles-setup.service ] || rm -f $i; done); \
	rm -f /etc/systemd/system/*.wants/*;\
	rm -f /lib/systemd/system/local-fs.target.wants/*; \
	rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
	rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
	rm -f /lib/systemd/system/basic.target.wants/*;\
	rm -f /lib/systemd/system/anaconda.target.wants/*;
	#rm -f /lib/systemd/system/multi-user.target.wants/*;\

# Without this, init won't start the enabled services and exec'ing and starting
# them reports "Failed to get D-Bus connection: Operation not permitted".

VOLUME /run /tmp /data /sys/fs/cgroup

CMD /usr/sbin/init

RUN yum update -y; \
yum install -y tomcat

EXPOSE 8080

ENV GEOSERVER_VERSION=2.12.1

RUN yum install -y unzip wget

WORKDIR /tmp

RUN wget http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-war.zip; \
unzip geoserver-${GEOSERVER_VERSION}-war.zip -d /var/lib/tomcat/webapps #-d makes dir if it doesn't exist

# Needs to be started in following fashion
# docker run -itd -v /sys/fs/cgroup:/sys/fs/cgroup:ro --cap-add=SYS_ADMIN --security-opt=seccomp:unconfined --stop-signal=SIGRTMIN+3 centos7qa
