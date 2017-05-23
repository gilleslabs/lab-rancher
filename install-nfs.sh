#!/bin/sh

sudo ufw disable

sudo apt-get update -y
sudo apt-get install nfs-kernel-server -y

sudo mkdir /convoy-nfs
sudo echo /convoy-nfs *\(rw,sync,no_root_squash\) > /etc/exports

sudo mkdir /nfs-share
sudo echo /nfs-share *\(rw,sync,no_root_squash\) >> /etc/exports

sudo mkdir /demo
sudo cp -R /vagrant/demo/. /demo/.
sudo chown -R vagrant:vagrant /demo
sudo echo /demo *\(rw,sync,no_root_squash\) >> /etc/exports

sudo service nfs-kernel-server start
sudo exportfs -u

