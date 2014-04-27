# encoding: utf-8
require 'aruba/cucumber'

# middleman
require 'middleman-core'
require 'middleman-core/step_definitions'

# Pull in all of the gems including those in the `test` group
require 'bundler'
Bundler.require :default, :test, :development
