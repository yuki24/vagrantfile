#!/usr/bin/env bash

apt-get update
apt-get upgrade -y
apt-get install -y git svn build-essential xvfb firefox

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

echo "Change /etc/postgresql/{version}/main/pg_hba.conf to always trust local connection:"
echo "  http://stackoverflow.com/questions/5421807/set-blank-password-for-postgresql-user"
echo "\n"
echo "Then run:"
echo '  -u postgres psql -d template1 -w --no-password -h localhost -p 5432 -t -c "CREATE USER vagrant; ALTER USER vagrant CREATEDB;'