# encoding: utf-8
$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.command_name 'rspec'
SimpleCov.start

# Pull in all of the gems including those in the `test` group
require 'bundler'
Bundler.require :default, :test, :development

require 'middleman-revealjs'

# Avoid writing "describe MyModule::MyClass do [..]" but "describe MyClass do [..]"
include Middleman::Revealjs
