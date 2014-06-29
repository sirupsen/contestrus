#!/bin/bash

set -ex

if [ $UID -ne 0 ]; then 
  echo "Run as root."
  exit 1
fi 
apt-get update
apt-get install -y software-properties-common
add-apt-repository -y ppa:pypy/ppa
add-apt-repository -y ppa:ubuntu-toolchain-r/test
apt-get update

# Install gcc, g++, pypy

apt-get install -y \
  build-essential \
  gcc-4.8 \
  g++-4.8 \
  wget \
  pypy \
  libreadline-gplv2-dev \
  libncursesw5-dev \
  libssl-dev 

update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 20
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 20

# Install Ruby 2.1.2

wget -O - https://rvm.io/binaries/ubuntu/14.04/x86_64/ruby-2.1.2.tar.bz2 | tar jxf - -C /usr/local/
ln -s /usr/local/ruby-2.1.2/bin/* /usr/local/bin/

# Install GoLang 1.1 (Go to 1.4)

wget -O- --no-check-certificate https://golang.org/dl/go1.3.linux-amd64.tar.gz | tar xzf - -C /usr/local
ln -s /usr/local/go/bin/go /usr/local/bin/go
ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc

# Install NodeJS

wget -O- http://nodejs.org/dist/v0.10.20/node-v0.10.20-linux-x64.tar.gz | tar xzf - -C /usr/local/

ln -s /usr/local/node-v0.10.20-linux-x64/bin/node /usr/local/bin/node
ln -s /usr/local/node-v0.10.20-linux-x64/bin/npm /usr/local/bin/npm

