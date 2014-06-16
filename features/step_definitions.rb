# encoding: utf-8
Given(/^I initialized middleman for a new presentation$/) do
  step %Q{I successfully run `middleman init --skip-bundle --template empty`}

  append_to_file('config.rb', "\nactivate :presentation\n")
  append_to_file('Gemfile', "\ngem 'middleman-presentation', path: '#{File.expand_path('../../', __FILE__)}'\n")

  step %Q{I successfully run `bundle install`}
end

Given(/^I created a new presentation with title "([^"]+)" for speaker "([^"]+)"$/) do |title, speaker|
  step %Q{I initialized middleman for a new presentation}
  step %Q{I successfully run `bundle install`}
  step %Q{I successfully run `bundle exec middleman presentation --title "#{title}" --speaker "#{speaker}"`}
  step %Q{I successfully run `bundle install`}
end

Given(/^I created a new presentation with title "(.*?)" for speaker "(.*?)" but kept existing files\/directories$/) do |title, speaker|
  step %Q{I initialized middleman for a new presentation}
  step %Q{I successfully run `bundle install`}
  step %Q{I successfully run `bundle exec middleman presentation --title "#{title}" --speaker "#{speaker}" --no-clear-source`}
  step %Q{I successfully run `bundle install`}
end

Given(/^a slide named "(.*?)" with:$/) do |slide_name, string|
  step %Q{a file named "source/slides/#{slide_name}" with:}, string
end

Then /^I go to "([^"]*)" and see the following error message:$/ do |url, message|
  message = capture :stderr do
    begin
      @browser.get(URI.escape(url))
    rescue StandardError
    end
  end

  expect(message).to include message
end

Given(/^a home directory for testing$/) do
  @_old_home = ENV['HOME']

  ENV['HOME'] = File.expand_path(current_dir)
end

Before do
  step %Q{a home directory for testing}
end

After do
  ENV['HOME'] = @_old_home
end


