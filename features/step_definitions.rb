# encoding: utf-8
Given(/^I initialized middleman for a new presentation$/) do
  step %Q{I successfully run `middleman init --skip-bundle`}

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

Given(/^a slide named "(.*?)" with:$/) do |slide_name, string|
  step %Q{a file named "source/slides/#{slide_name}" with:}, string
end
