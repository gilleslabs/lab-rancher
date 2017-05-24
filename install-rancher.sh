#!/bin/sh
sudo echo nameserver 8.8.8.8 > /run/resolvconf/resolv.conf


sudo ufw allow 8080/tcp 
sudo ufw allow 500/udp
sudo ufw allow 4500/udp
sudo ufw allow 4789/udp

sudo docker run -d --restart=unless-stopped -e CATTLE_PROMETHEUS_EXPORTER=true -p 8080:8080 -p 9108:9108 rancher/server

###### Enabling Rancher-Server to run containers - !!!!WARNING!!! Agent version may change => check in Rancher GUI
sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.2 http://10.200.193.100:8080

 