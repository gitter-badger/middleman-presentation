# encoding: utf-8
Given(/^I initialized middleman for a new presentation$/) do
  step 'I successfully run `middleman init --skip-bundle --template empty`'

  append_to_file('config.rb', "\nactivate :presentation\n")
  append_to_file('Gemfile', "\ngem 'middleman-presentation', path: '#{File.expand_path('../../', __FILE__)}'\n")

  step 'I successfully run `bundle install`'
end

Given(/I install bundle/) do
  step 'I successfully run `bundle update`'
end

Given(/^I created a new presentation with title "([^"]+)" for speaker "([^"]+)"$/) do |title, speaker|
  step 'I initialized middleman for a new presentation'
  step 'I successfully run `bundle install`'
  step %Q(I successfully run `bundle exec middleman presentation --title "#{title}" --speaker "#{speaker}"`)
  step 'I successfully run `bundle install`'
end

Given(/^I created a new presentation with title "(.*?)" for speaker "(.*?)" but kept existing files\/directories$/) do |title, speaker|
  step 'I initialized middleman for a new presentation'
  step 'I successfully run `bundle install`'
  step %Q(I successfully run `bundle exec middleman presentation --title "#{title}" --speaker "#{speaker}" --no-clear-source`)
  step 'I successfully run `bundle install`'
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
  step %Q(I remove the directory "#{name}")
end

Then(/^a presentation theme named "(.*?)" should exist( with default files\/directories created)?$/) do |name, default_files|
  step %Q(a directory named "#{name}" should exist)

  if default_files
    step %Q(a directory named "#{name}/stylesheets" should exist)
    step %Q(a directory named "#{name}/javascripts" should exist)
  end
end

Then(/^I go to "([^"]*)" and see the following error message:$/) do |url, message|
  message = capture :stderr do
    begin
      @browser.get(URI.escape(url))
    rescue StandardError
    end
  end

  expect(message).to include message
end

Then(/^a directory named "(.*?)" is a git repository$/) do |name|
  step %Q(a directory named "#{name}/.git" should exist)
end

Then(/^the status code should be "([^\"]*)"$/)do |expected|
  expect(@browser.last_response.status).to eq expected.to_i
end

Then(/^I should not see:$/) do |expected|
  expect(@browser.last_response.body).not_to include(expected.chomp)
end

Then(/^a slide named "(.*?)" exist with:$/) do |name, string|
  step %Q(the file "source/slides/#{name}" should contain:), string
end
