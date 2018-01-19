#!/bin/bash

##Install docker

sudo wget -qO- https://get.docker.com/ | sh
sudo usermod -aG docker vagrant

##Make Geoserve directory and move file across
sudo mkdir /home/vagrant/Geoserver
sudo cp /tmp/shared/Dockerfile /home/vagrant/Geoserver/

##Edit resolv.conf file so docker containers point to a working DNS

sudo echo "nameserver 151.170.240.3" >> /etc/resolv.conf
sudo echo "nameserver 151.170.240.4" >> /etc/resolv.conf

##Build docker image
cd /home/vagrant/Geoserver && sudo docker build -t geoserv .
sudo docker run -itd -p 8080:8080 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --cap-add=SYS_ADMIN --name=geoservCon --security-opt=seccomp:unconfined --stop-signal=SIGRTMIN+3 geoserv
sudo docker exec geoservCon systemctl start tomcat
