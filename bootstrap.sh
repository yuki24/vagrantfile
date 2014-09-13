#!/usr/bin/env bash

apt-get update
apt-get upgrade -y
apt-get install -y git svn emacs build-essential silversearcher-ag tree

# nokogiri requirements
apt-get install -y libxslt-dev libxml2-dev

# pg gem requirements
apt-get install -y postgresql postgresql-server-dev-9.3 postgresql-contrib

# Installs nvm. picked up from:
#   https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server
curl https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | sh
source ~/.profile

# Installs rvm.
curl -sSL https://get.rvm.io | bash
rvm reload
rvm install 2.0.0
rvm use 2.0.0 --default

chown -R vagrant /usr/local/rvm

git config --global user.name "Yuki Nishijima"
git config --global user.email mail@yukinishijima.net
git config --global core.editor emacs

echo "Change /etc/postgresql/{version}/main/pg_hba.conf to always trust local connection:"
echo "  http://stackoverflow.com/questions/5421807/set-blank-password-for-postgresql-user"
echo ""
echo "Then run:"
echo '  -u postgres psql -d template1 -w --no-password -h localhost -p 5432 -t -c "CREATE USER vagrant; ALTER USER vagrant CREATEDB;'