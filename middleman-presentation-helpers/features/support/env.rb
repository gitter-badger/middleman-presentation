# encoding: utf-8
require 'aruba/cucumber'

require 'simplecov'
SimpleCov.command_name 'cucumber'
SimpleCov.start

# middleman
require 'middleman-core'
require 'middleman-core/step_definitions'
require 'middleman-presentation-core/step_definitions'

# Pull in all of the gems including those in the `test` group
require 'bundler'
Bundler.require :default, :test, :development

ENV['TEST'] = 'true'
ENV['AUTOLOAD_SPROCKETS'] = 'false'

PROJECT_ROOT_PATH = File.expand_path('../../../', __FILE__)
