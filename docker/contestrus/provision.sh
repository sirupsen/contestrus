#!/bin/bash

set -ex

cd /app
./script/bootstrap
bin/rake assets:precompile
