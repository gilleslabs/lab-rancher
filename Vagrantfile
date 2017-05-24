# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
  else
    config.vm.synced_folder ".", "/vagrant"
  end
 
  config.vm.define "repo-server" do |d|
    d.vm.box = "ubuntu/trusty64"
    d.vm.hostname = "repo-server"
    d.vm.network "private_network", ip: "10.200.194.10"
	d.vm.network "private_network", ip: "10.200.193.10"
	d.vm.provision :shell, inline: "sudo echo nameserver 8.8.8.8 > /run/resolvconf/resolv.conf"
    d.vm.provision :shell, path: "install-docker.sh"
	d.vm.provision :shell, path: "install-apt-cache.sh"
	d.vm.provision :shell, path: "setup-registry.sh"
	d.vm.provider "virtualbox" do |v|
      v.memory = 1024
	  v.cpus = 2
    end
  end 

 
  config.vm.define "infra-server" do |d|
    d.vm.box = "ubuntu/trusty64"
    d.vm.hostname = "infra-server"
    d.vm.network "private_network", ip: "10.200.194.100"
	d.vm.network "private_network", ip: "10.200.193.100"
    d.vm.provision :shell, inline: "sudo echo 10.200.193.10  registry.infra.local >> /etc/hosts"
	d.vm.provision :shell, path: "set-apt-cache.sh"
    d.vm.provision :shell, path: "install-docker.sh"
	d.vm.provision :shell, path: "set-registry.sh"
    d.vm.provision :shell, path: "install-nfs.sh"
    d.vm.provision :shell, path: "install-bind.sh"
	d.vm.provision :shell, path: "install-rebound.sh"
	d.vm.provision :shell, inline: "sudo echo nameserver 10.200.194.100 > /run/resolvconf/resolv.conf"
	d.vm.provision :shell, path: "vagrant-dns-patch.sh"
	d.vm.provision :shell, path: "install-rancher.sh"
	d.vm.provider "virtualbox" do |v|
      v.memory = 2048
	  v.cpus = 2
    end
  end
  
  
  
  (1..6).each do |i|
    config.vm.define "node-#{i}" do |d|
      d.vm.box = "ubuntu/trusty64"
      d.vm.hostname = "swarm-#{i}"
      d.vm.network "private_network", ip: "10.200.192.20#{i}"
	  d.vm.network "private_network", ip: "10.200.193.20#{i}"
	  d.vm.provision :shell, inline: "sudo echo nameserver 10.200.194.100 > /run/resolvconf/resolv.conf"
      d.vm.provision :shell, path: "vagrant-dns-patch.sh"
	  d.vm.provision :shell, path: "set-apt-cache.sh"
      d.vm.provision :shell, path: "install-docker.sh"
	  d.vm.provision :shell, path: "set-registry.sh"
      d.vm.provider "virtualbox" do |v|
        v.memory = 2048
		v.cpus = 2
      end
    end
  end
  
  end