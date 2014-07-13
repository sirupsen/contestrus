#!/bin/bash

set -ex

if [ $UID -ne 0 ]; then
  echo "Please run script/provision-basic as root."
  exit 1
fi

apt-get update

apt-get install -y \
  sqlite3 \
  libsqlite3-dev \
  vim \
  libreadline6-dev \
  libyaml-dev \
  wget \
  build-essential \
  libssl-dev \
  git 

# install ruby

wget -O - https://rvm.io/binaries/ubuntu/14.04/x86_64/ruby-2.1.2.tar.bz2 | tar jxf - -C /usr/local/

ln -s /usr/local/ruby-2.1.2/bin/* /usr/local/bin/

export GEM_HOME=$HOME/.gems
export PATH=$HOME/.gems/bin:$PATH
## Create .ssh and an empty authorized_keys for app
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys

## Add github.com public keys to known_hosts
if [ ! -f ~/.ssh/known_hosts ]; then
  cat > ~/.ssh/known_hosts <<KNOWN_HOSTS
|1|diWgaRR5v1U/5b2V5BFjWVApxvY=|VEprbEVtgtMebXhmNB7yfc77kDc= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
|1|4n4ARSOPBEmRUVOWaKiI3XsjmG4=|QIanVGwVfEQeKfWgWkUrhXi6Vkg= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
KNOWN_HOSTS
fi

#install contestrus

git clone https://github.com/sirupsen/contestrus.git ~/contestrus

cd ~/contestrus

gem install bundler --no-rdoc --no-ri
# set up contestrus

./script/setup 
