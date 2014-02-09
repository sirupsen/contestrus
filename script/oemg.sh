#!/bin/bash

config() {
  echo $1 | ruby -r yaml -e "\
begin
  value = gets.chomp.split(':')
              .inject(YAML.load_file('./config/app_config.yml')) { |config, key|
                 config[key]
              }
rescue
  exit 1
end

if value
  puts value
  exit 0
else
  exit 1
end
  "
}
