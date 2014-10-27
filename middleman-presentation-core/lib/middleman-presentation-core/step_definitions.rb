# encoding: utf-8

Before do
  @aruba_timeout_seconds = 120
  ENV['MM_ENV'] = 'development'
  ENV['MP_ENV'] = 'test'

  step 'I set the bower cache directory'
  step 'a mocked home directory'
  step 'git is configured with username "User" and email-address "email@example.com"'
  step 'I set the language for the shell to "en_GB.UTF-8"'
end

Given(/I set the bower cache directory/) do
  ENV['bower_storage__packages'] = File.expand_path('../../../../tmp/bower_cache', __FILE__)
end

Given(/I set the bundler cache directory/) do
  ENV['BUNDLE_PATH'] = File.expand_path('../../../../tmp/bundler_cache', __FILE__)
end

# Clean environment
Around do |_, block|
  old_env = ENV.to_h

  block.call

  ENV.replace old_env
end

When(/^I start debugging/) do
  # rubocop:disable Lint/Debugger
  require 'pry'
  binding.pry
  # rubocop:enable Lint/Debugger

  ''
end

Given(/^I set the language for the shell to "([^"]+)"$/) do |language|
  set_env 'LANG', language
end

Given(/only the executables of gems "([^"]+)" can be found in PATH/) do |gems|
  dirs = []

  dirs.concat gems.split(/,\s?/).map(&:strip).each_with_object([]) { |e, a| a << Gem::Specification.find_by_name(e).bin_dir }

  if ci?
    dirs << "/home/travis/.rvm/rubies/ruby-#{RUBY_VERSION}/bin"
    dirs << "/home/travis/.rvm/rubies/ruby-#{Gem.ruby_api_version}/bin" unless Gem.ruby_api_version == RUBY_VERSION
  end

  dirs << '/usr/bin'

  set_env 'PATH', dirs.join(':')
end

Given(/^I create a new presentation with title "([^"]+)"(?: for speaker "([^"]+)")?(?: on "([^"]+)")?$/) do |title, speaker, date|
  options = {}
  options[:title] = title
  options[:speaker] = speaker if speaker
  options[:date] = date if date

  step %(I successfully run `middleman-presentation create presentation presentation1 #{options.to_options.join(' ')}`)
  step 'I cd to "presentation1"'
  # step 'I remove all bundler files'
end

Given(/^I prepend "([^"]+)" to environment variable "([^"]+)"$/) do |value, variable|
  set_env variable, value + ENV[variable]
end

Given(/^a slide named "(.*?)" with:$/) do |name, string|
  step %(a file named "source/slides/#{name}" with:), string
end

Given(/^a project template named "(.*?)" with:$/) do |name, string|
  step %(a file named "templates/#{name}" with:), string
end

Given(/^a user template named "(.*?)" with:$/) do |name, string|
  step %(a file named "~/.config/middleman/presentation/templates/#{name}" with:), string
end

Given(/^a presentation theme named "(.*?)" does not exist$/) do |name|
  step %(I remove the directory "middleman-presentation-theme-#{name}")
end

Given(/^a plugin named "(.*?)" does not exist$/) do |name|
  step %(I remove the directory "#{name}")
end

Then(%r{^a plugin named "(.*?)" should exist( with default files/directories created)?$}) do |name, default_files|
  step %(a directory named "#{name}" should exist)

  if default_files
    %W(
      #{name}/#{name}.gemspec
      #{name}/lib/#{name}.rb
      #{name}/lib/#{name}/version.rb
      #{name}/Gemfile
      #{name}/LICENSE.txt
      #{name}/README.md
      #{name}/Rakefile
      #{name}/.gitignore
    ).each do |file|
      step %(a file named "#{file}" should exist)
    end

    %W(
      #{name}/lib
      #{name}/lib/#{name}
    ).each do |file|
      step %(a directory named "#{file}" should exist)
    end
  end
end

Given(/^git is configured with username "(.*?)" and email-address "(.*?)"$/) do |name, email|
  step %(I successfully run `git config --global user.email "#{email}"`)
  step %(I successfully run `git config --global user.name "#{name}"`)
end

Given(/^a user config file for middleman\-presentation with:$/) do |string|
  step 'a file named "~/.config/middleman/presentation/presentations.yaml" with:', string
end

Then(/^the user config file for middleman\-presentation should contain:$/) do |string|
  step 'the file "~/.config/middleman/presentation/presentations.yaml" should contain:', string
end

Then(%r{^a presentation theme named "(.*?)" should exist( with default files/directories created)?$}) do |name, default_files|
  name = "middleman-presentation-theme-#{name}"

  step %(a directory named "#{name}" should exist)

  if default_files
    step %(a directory named "#{name}/stylesheets" should exist)
    step %(a directory named "#{name}/javascripts" should exist)
  end
end

Then(/^I go to "([^"]*)" and see the following error message:$/) do |url, message|
  message = capture :stderr do
    # rubocop:disable Lint/HandleExceptions:
    begin
      @browser.get(URI.escape(url))
    rescue StandardError
    end
    # rubocop:enable Lint/HandleExceptions:
  end

  expect(message).to include message
end

Then(/^a directory named "(.*?)" is a git repository$/) do |name|
  step %(a directory named "#{name}/.git" should exist)
end

Given(/^a slide named "(.*?)" does not exist$/) do |name|
  in_current_dir do
    FileUtils.rm_rf File.expand_path(File.join('source', 'slides', name))
  end
end

Then(/^a slide named "(.*?)" should exist$/) do |name|
  step %(a file named "source/slides/#{name}" should exist)
end

Then(/^a slide named "(.*?)" should exist with:$/) do |name, string|
  step %(the file "source/slides/#{name}" should contain:), string
end

Given(/I remove all bundler files$/) do
  FileUtils.rm_f File.expand_path(File.join(current_dir, 'Gemfile'))
  FileUtils.rm_f File.expand_path(File.join(current_dir, 'Gemfile.lock'))
end

# Given(/I replace all bundler files$/) do
#  src = File.expand_path(File.join('..', '..', '..', '..', 'Gemfile'), __FILE__)
#  dst = File.expand_path(File.join(current_dir, 'Gemfile'))
#
#  FileUtils.cp src, dst
# end

When(/^I successfully run `([^`]+)` in clean environment$/) do |command|
  Bundler.with_clean_env do
    step %(I successfully run `#{command}`)
  end
end

Given(/^I add a stylesheet asset named "(.*?)" to the presentation$/) do |asset|
  import_string = "@import '#{asset}';"

  step 'I append to "source/stylesheets/application.scss" with:', import_string
end

When(/^I run `([^`]+)` in debug mode$/) do |cmd|
  in_current_dir do
    system(cmd)
  end
end
