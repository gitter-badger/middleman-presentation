# encoding: utf-8
Given(/^I initialized middleman for a new presentation$/) do
  step %Q{I successfully run `middleman init --skip-bundle`}

  append_to_file('config.rb', "\nactivate :presentation\n")
  append_to_file('Gemfile', "\ngem 'middleman-presentation', path: '#{File.expand_path('../../', __FILE__)}'\n")

  step %Q{I successfully run `bundle install`}
end

