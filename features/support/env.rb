# encoding: utf-8
require 'aruba/cucumber'

# middleman
require 'middleman-core'
require 'middleman-core/step_definitions'

# Pull in all of the gems including those in the `test` group
require 'bundler'
Bundler.require :default, :test, :development

require 'simplecov'
SimpleCov.command_name 'cucumber'
SimpleCov.start

ENV['TEST'] = 'true'
ENV['AUTOLOAD_SPROCKETS'] = 'false'

PROJECT_ROOT_PATH = File.expand_path('../../../', __FILE__)
