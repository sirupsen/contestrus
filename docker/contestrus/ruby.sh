#!/bin/bash

wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz -O - \
  | tar -xzf -

(
  cd ruby*
  ./configure --disable-install-docs
  make
  make install
)

gem install bundler --no-ri --no-rdoc
bundle --version
