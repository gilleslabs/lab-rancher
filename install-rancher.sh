#!/bin/sh

sudo ufw allow 8080/tcp 
sudo ufw allow 500/udp
sudo ufw allow 4500/udp
sudo ufw allow 4789/udp

sudo docker run -d --restart=unless-stopped -e CATTLE_PROMETHEUS_EXPORTER=true -p 8080:8080 -p 9108:9108 rancher/server

