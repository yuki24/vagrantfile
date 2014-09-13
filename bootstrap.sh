#!/usr/bin/env bash

apt-get update
apt-get upgrade -y
apt-get install -y git svn emacs build-essential silversearcher-ag tree tcl8.5 memcached

# nokogiri requirements
apt-get install -y libxslt-dev libxml2-dev

# pg gem requirements
apt-get install -y postgresql postgresql-server-dev-9.3 postgresql-contrib

# Installs nvm. picked up from:
#   https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server
curl https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | sh
source ~/.profile

# Installs rvm
curl -sSL https://get.rvm.io | bash
/usr/local/rvm/bin/rvm reload
/usr/local/rvm/bin/rvm install 2.1.2
/usr/local/rvm/bin/rvm use 2.1.2 --default

chown -R vagrant /usr/local/rvm

# Installs phantomjs
cd /usr/local/share
sudo wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
sudo tar xjf phantomjs-1.9.7-linux-x86_64.tar.bz2
sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
sudo ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

# Installs redis
cd /tmp
wget http://download.redis.io/releases/redis-2.8.15.tar.gz
tar xzf redis-2.8.15.tar.gz
cd redis-2.8.15
make
make install
# cd utils
# ./install_server.sh

# My emacs lisp
cd ~/
git clone git://github.com/yuki24/emacs.el.git site-lisp
cp site-lisp/.emacs.el .
cd .emacs.d
git clone git://github.com/eschulte/rinari.git
cd rinari
git submodule init
git submodule update

cp /Users/yuki/GitHub/Vagrant/.bash_aliases ~/.bash_aliases
cp /Users/yuki/GitHub/Vagrant/.bash_yuki24 ~/.bash_yuki24

# postgres config
su - postgres -c "createuser vagrant -d -r -s"

echo "Change /etc/postgresql/{version}/main/pg_hba.conf to always trust local connection:"
echo "  http://stackoverflow.com/questions/5421807/set-blank-password-for-postgresql-user"
