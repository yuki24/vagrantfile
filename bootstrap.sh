#!/usr/bin/env bash

# Install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
source ~/.profile

# Install rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

# Install ruby-build
mkdir ~/.rbenv/plugins
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# rbenv install 2.3.0
# rbenv install 2.4.0-dev

cd /home/vagrant
git clone https://github.com/yuki24/vagrantfile.git Vagrant
ln -s ~/Vagrant/.bash_aliases ~/.bash_aliases

echo 'if [ -f ~/.bash_custom ]; then' >> ~/.bashrc
echo '  . ~/.bash_custom'             >> ~/.bashrc
echo 'fi'                             >> ~/.bashrc
ln -s ~/Vagrant/.bash_custom ~/.bash_custom

# Install cask
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
export PATH="/home/vagrant/.cask/bin:$PATH"
echo 'export PATH="/home/vagrant/.cask/bin:$PATH"' >> ~/.bashrc

# Set up emacs
cd ~/
git clone git://github.com/yuki24/emacs.el.git site-lisp
cd site-lisp && git checkout vagrant
ln -s ~/site-lisp/.emacs.el ~/.emacs.el
mkdir ~/.emacs.d
ln -s ~/Vagrant/Cask ~/.emacs.d/Cask
cd ~/.emacs.d
cask install

# set up gitignore
curl https://www.gitignore.io/api/emacs%2Cosx%2Cintellij%2Cvim > ~/.gitignore
git config --global core.excludesfile '~/.gitignore'

# postgres config
sudo su - postgres -c "createuser vagrant -d -r -s"
echo "Change /etc/postgresql/{version}/main/pg_hba.conf to always trust local connection:"
echo "  http://stackoverflow.com/questions/5421807/set-blank-password-for-postgresql-user"
