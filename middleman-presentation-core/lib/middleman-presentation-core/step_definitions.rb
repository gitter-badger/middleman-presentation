# encoding: utf-8
Before do
  @aruba_timeout_seconds = 120
  ENV['MM_ENV'] = 'development'
  ENV['MP_ENV'] = 'test'

  step 'a mocked home directory'
  step 'I configure bundler for fast testing'
  step 'git is configured with username "User" and email-address "email@example.com"'
  step 'I set the language for the shell to "en_GB.UTF-8"'
end

Given(/I configure bundler for fast testing/) do
  config = []
  config << "BUNDLE_PATH: #{ENV['BUNDLE_PATH']}" if ENV.key? 'BUNDLE_PATH'

  config_file = File.join ENV['HOME'], '.bundle', 'config'

  FileUtils.mkdir_p File.dirname(config_file)
  File.write config_file, config.join("\n")
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

Given(/^I use presentation fixture "([^"]+)" with title "([^"]+)"(?: and date "([^"]+)")?$/) do |name, title, date|
  directory = []
  directory << name
  directory << ('-' + title)
  directory << ('-' + date) if date

  directory = directory.join.characterize

  command = []
  command << "middleman-presentation create presentation #{temporary_fixture_path(directory)}"
  command << "--title #{Shellwords.escape(title)}"
  command << "--date #{Shellwords.escape(date)}" if date

  system(command.join(' ')) unless temporary_fixture_exist?(directory)

  FileUtils.cp_r temporary_fixture_path(directory), absolute_path(name)
  step %(I cd to "#{name}")
end

Given(/^I set the language for the shell to "([^"]+)"$/) do |language|
  set_env 'LANG', language
end

Given(/only the executables of gems "([^"]+)" can be found in PATH/) do |gems|
  dirs = []

  dirs.concat gems.split(/,\s?/).map(&:strip).each_with_object([]) do |e, a| 
    gem = Gem::Specification.find_by_name(e)

    next if gem.blank?

    a << gem.bin_dir 
  end

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
  step %(a file named "~/.config/middleman-presentation/templates/#{name}" with:), string
end

Given(/^a presentation theme named "(.*?)" does not exist$/) do |name|
  step %(I remove the directory "middleman-presentation-theme-#{name}")
end

Given(/^a file named "(.*?)" does not exist$/) do |name|
  FileUtils.rm_rf absolute_path(name)
end

Given(/^a directory named "(.*?)" does not exist$/) do |name|
  step %(I remove the directory "#{name}")
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
  step 'a file named "~/.config/middleman-presentation/application.yaml" with:', string
end

Given(/^a presentation config file for middleman\-presentation with:$/) do |string|
  step 'a file named ".middleman-presentation.yaml" with:', string
end

Then(/^the user config file for middleman\-presentation should contain:$/) do |string|
  step 'the file "~/.config/middleman-presentation/application.yaml" should contain:', string
end

Then(/^the presentation config file for middleman\-presentation should contain:$/) do |string|
  step 'the file ".middleman-presentation.yaml" should contain:', string
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
  FileUtils.rm_rf absolute_path('source', 'slides', name)
end

Then(/^a slide named "(.*?)" should exist$/) do |name|
  step %(a file named "source/slides/#{name}" should exist)
end

Then(/^a slide named "(.*?)" should exist with:$/) do |name, string|
  step %(the file "source/slides/#{name}" should contain:), string
end

When(/^I successfully run `([^`]+)` in clean environment$/) do |command|
  Bundler.with_clean_env do
    step %(I successfully run `#{command}`)
  end
end

Given(/^I add a stylesheet asset named "(.*?)" to the presentation$/) do |asset|
  import_string = "@import '#{asset}';"

  step 'I append to "source/stylesheets/application.scss" with:', import_string
end

When(/^I successfully run `([^`]+)` in debug mode$/) do |cmd|
  step "I run `#{cmd}` in debug mode"
end

When(/^I run `([^`]+)` in debug mode$/) do |cmd|
  in_current_dir do
    # rubocop:disable Lint/Debugger
    require 'pry'
    binding.pry
    # rubocop:enable Lint/Debugger
    system(cmd)
  end
end

Then(/^the size of "(.*?)" should be much smaller than from  "(.*?)"$/) do |file1, file2|
  in_current_dir do
    expect(File.size(file1)).to be < File.size(file2)
  end
end
