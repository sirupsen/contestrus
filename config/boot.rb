# require_relative '../vendor/bundle/bundler/setup'

$:.unshift File.expand_path '../vendor/bundle', __FILE__

require 'bundler/setup'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
