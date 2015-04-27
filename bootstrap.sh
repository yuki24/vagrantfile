#!/usr/bin/env bash

# Add MongoDB repository
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

apt-get update
apt-get upgrade -y
apt-get install -y git emacs build-essential silversearcher-ag tree tcl8.5 memcached mongodb-org

# nokogiri requirements
apt-get install -y libxslt-dev libxml2-dev

# pg gem requirements
apt-get install -y postgresql postgresql-server-dev-9.3 postgresql-contrib

# Installs nvm. picked up from:
#   https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server
curl https://raw.githubusercontent.com/creationix/nvm/v0.25.0/install.sh | sh
source ~/.profile

# Installs rvm
curl -sSL https://get.rvm.io | bash
/usr/local/rvm/bin/rvm reload
/usr/local/rvm/bin/rvm install ruby
/usr/local/rvm/bin/rvm use ruby --default

chown -R vagrant /usr/local/rvm

# Installs phantomjs
cd /usr/local/share
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
tar xjf phantomjs-1.9.8-linux-x86_64.tar.bz2
ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
ln -s /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

# Installs redis
cd /tmp
wget http://download.redis.io/releases/redis-2.8.15.tar.gz
tar xzf redis-2.8.15.tar.gz
cd redis-2.8.15
make
make install
cd utils
./install_server.sh

cd /home/vagrant
ln -s /GitHub/Vagrant/.bash_aliases ~/.bash_aliases
ln -s /GitHub/Vagrant/.bash_yuki24 ~/.bash_yuki24

# installs cask
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
export PATH="/root/.cask/bin:$PATH"

# sets up emacs for me
cd /Github
git clone git://github.com/yuki24/emacs.el.git site-lisp
cd site-lisp && git checkout vagrant
ln -s /GitHub/site-lisp/.emacs.el ~/.emacs.el
mkdir ~/.emacs.d
ln -s /GitHub/Vagrant/Cask ~/.emacs.d/Cask
cd ~/.emacs.d
cask install

chown vagrant -R /home/vagrant

# postgres config
su - postgres -c "createuser vagrant -d -r -s"

echo "Change /etc/postgresql/{version}/main/pg_hba.conf to always trust local connection:"
echo "  http://stackoverflow.com/questions/5421807/set-blank-password-for-postgresql-user"
