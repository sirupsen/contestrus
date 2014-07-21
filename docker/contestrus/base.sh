#!/bin/bash

set -ex

export DEBIAN_FRONTEND="noninteractive"

apt-get update
apt-get upgrade -f -y --force-yes

apt-get install -y \
  sqlite3 \
  libsqlite3-dev \
  vim \
  libreadline6-dev \
  libyaml-dev \
  zlib1g-dev \
  wget \
  build-essential \
  libssl-dev \
  git \
  libffi-dev
