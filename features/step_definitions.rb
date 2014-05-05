# encoding: utf-8
Given(/^I initialized middleman for a new presentation$/) do
  step %Q{I successfully run `middleman init --skip-bundle`}

  append_to_file('config.rb', 'activate :presentation')
  append_to_file('Gemfile', 'gem "middleman-presentation"')
end

