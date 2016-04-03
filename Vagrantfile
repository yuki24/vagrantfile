# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64"
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  # config.vm.network :private_network, ip: "192.168.33.10"
  # config.vm.network :public_network
  config.ssh.forward_agent = true
  config.vm.synced_folder "~/GitHub", "/GitHub"
  config.vm.define "phusion-ubuntu-14.04-amd64"
  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"]  = "2048"
    v.vmx["numvcpus"] = "4"
  end

  config.vm.provision :shell, inline: <<-SCRIPT
    # Add MongoDB repository
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

    apt-get remove upppet
    apt-get autoremove

    apt-get update
    apt-get upgrade -y
    apt-get install -y git build-essential silversearcher-ag tree tcl8.5 memcached mongodb-org autoconf libssl-dev libreadline-dev bison

    # nokogiri requirements
    apt-get install -y libxslt-dev libxml2-dev

    # pg gem requirements
    apt-get install -y postgresql postgresql-server-dev-9.3 postgresql-contrib

    # phantomjs
    cd /usr/local/share
    wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
    tar xjf phantomjs-2.1.1-linux-x86_64.tar.bz2
    ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
    ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
    ln -s /usr/local/share/phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

    # redis
    cd /tmp
    wget http://download.redis.io/releases/redis-3.0.7.tar.gz
    tar xzf redis-3.0.7.tar.gz
    cd redis-3.0.7
    make
    make install
    cd utils
    ./install_server.sh

    # emacs 24.4
    apt-get build-dep -y emacs24
    cd /tmp
    wget http://mirror.team-cymru.org/gnu/emacs/emacs-24.4.tar.gz
    tar xvf emacs-24.4.tar.gz
    cd emacs-24.4
    ./configure
    make
    make install
  SCRIPT

  config.vm.provision :shell, path: "bootstrap.sh", privileged: false
end
