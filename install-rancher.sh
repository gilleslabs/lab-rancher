#!/bin/sh

sudo ufw allow 8080/tcp 
sudo ufw allow 500/udp
sudo ufw allow 4500/udp
sudo ufw allow 4789/udp

sudo docker run -d --restart=unless-stopped -e CATTLE_PROMETHEUS_EXPORTER=true -p 8080:8080 -p 9108:9108 rancher/server

###### Enabling Rancher-Server to run containers - !!!!WARNING!!! Agent version may change => check in Rancher GUI
sudo docker run -d --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.2 http://rancher.infra.local:8080

 