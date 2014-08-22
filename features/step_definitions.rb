# encoding: utf-8

Before do
  @aruba_timeout_seconds = 120
  ENV['MM_ENV'] = 'development'

  step 'a mocked home directory'
  step 'git is configured with username "User" and email-address "email@example.com"'
end

# Clean environment
Around do |_, block|
  old_env = ENV.to_h

  block.call

  ENV.replace old_env
end

Given(/^an image "([^"]+)" at "([^"]+)"$/) do |source, destination|
  source = source.gsub(/\.\./, '')
  write_file File.join('source', destination), File.read(File.expand_path("../../fixtures/images/#{source}", __FILE__))
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

Given(/^I create a new presentation with title "([^"]+)"(?: for speaker "([^"]+)")?$/) do |title, speaker|
  options = {}
  options[:title] = title
  options[:speaker] = speaker if speaker

  step %Q(I successfully run `middleman-presentation create presentation presentation1 #{options.to_options.join(' ')}`)
  step 'I cd to "presentation1"'
  step 'I remove all bundler files'
end

Given(/^I prepend "([^"]+)" to environment variable "([^"]+)"$/) do |value, variable|
  set_env variable, value + ENV[variable]
end

Given(/^a slide named "(.*?)" with:$/) do |name, string|
  step %Q(a file named "source/slides/#{name}" with:), string
end

Given(/^a project template named "(.*?)" with:$/) do |name, string|
  step %Q(a file named "templates/#{name}" with:), string
end

Given(/^a user template named "(.*?)" with:$/) do |name, string|
  step %Q(a file named "~/.config/middleman/presentation/templates/#{name}" with:), string
end

Given(/^a presentation theme named "(.*?)" does not exist$/) do |name|
  step %Q(I remove the directory "middleman-presentation-theme-#{name}")
end

Given(/^git is configured with username "(.*?)" and email-address "(.*?)"$/) do |name, email|
  step %Q(I successfully run `git config --global user.email "#{email}"`)
  step %Q(I successfully run `git config --global user.name "#{name}"`)
end

Given(/^a user config file for middleman\-presentation with:$/) do |string|
  step 'a file named "~/.config/middleman/presentation/presentations.yaml" with:', string
end

Then(/^the user config file for middleman\-presentation should contain:$/) do |string|
  step 'the file "~/.config/middleman/presentation/presentations.yaml" should contain:', string
end

Then(/^a presentation theme named "(.*?)" should exist( with default files\/directories created)?$/) do |name, default_files|
  name = "middleman-presentation-theme-#{name}"

  step %Q(a directory named "#{name}" should exist)

  if default_files
    step %Q(a directory named "#{name}/stylesheets" should exist)
    step %Q(a directory named "#{name}/javascripts" should exist)
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
  step %Q(a directory named "#{name}/.git" should exist)
end

Then(/^a slide named "(.*?)" exist with:$/) do |name, string|
  step %Q(the file "source/slides/#{name}" should contain:), string
end

Given(/I remove all bundler files$/) do
  FileUtils.rm File.expand_path(File.join(current_dir, 'Gemfile'))
  FileUtils.rm File.expand_path(File.join(current_dir, 'Gemfile.lock'))
end

When(/^I successfully run `([^`]+)` in clean environment$/) do |command|
  Bundler.with_clean_env do
    step %Q(I successfully run `#{command}`)
  end
end

Given(/^I add a stylesheet asset named "(.*?)" to the presentation$/) do |asset|
  import_string = "@import '#{asset}';"

  step 'I append to "source/stylesheets/application.scss" with:', import_string
end
