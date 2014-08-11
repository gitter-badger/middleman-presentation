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

Given(/only the executables of gems "([^"]+)" can be found in PATH/) do |gems|
  dirs = []

  puts ENV['PATH']

  dirs.concat gems.split(/,/).map(&:strip).each_with_object([]) { |e, a| a << Gem::Specification.find_by_name(e).bin_dir }

  if ci?
    dirs << "/home/travis/.rvm/rubies/ruby-#{RUBY_VERSION}/bin"
    dirs << "/home/travis/.rvm/rubies/ruby-#{Gem.ruby_api_version}/bin" unless Gem.ruby_api_version == RUBY_VERSION
  end

  dirs << '/usr/bin'

  set_env 'PATH', dirs.join(':')
end

Given(/^I created a new presentation with title "([^"]+)" for speaker "([^"]+)"$/) do |title, speaker|
  step 'I initialized middleman for a new presentation'
  step 'I successfully run `bundle install`'
  step %Q(I successfully run `bundle exec middleman-presentation init presentation --title "#{title}" --speaker "#{speaker}"`)
  step 'I successfully run `bundle install`'
end

Given(/^I created a new presentation with title "(.*?)" for speaker "(.*?)" but kept existing files\/directories$/) do |title, speaker|
  step 'I initialized middleman for a new presentation'
  step 'I successfully run `bundle install`'
  step %Q(I successfully run `bundle exec middleman-presentation init presentation --title "#{title}" --speaker "#{speaker}" --no-clear-source`)
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

Given(/^git is configured with username "(.*?)" and email-address "(.*?)"$/) do |name, email|
  step %Q(I successfully run `git config --global user.email "#{email}"`)
  step %Q(I successfully run `git config --global user.name "#{name}"`)
end

# Given(/^I configured bower correctly$/) do
#  http_proxy = %w(http_proxy HTTP_PROXY).find { |v| !ENV[v].blank? }
#  if http_proxy
#    http_proxy = Adressable::URI.heuristic_parse(ENV[variable])
#    http_proxy = "http://#{http_proxy.host}:#{http_proxy.port}"
#  end
#
#  https_proxy = %w(https_proxy HTTPS_PROXY).find { |v| !ENV[v].blank? }
#  if https_proxy
#    https_proxy = Adressable::URI.heuristic_parse(ENV[variable])
#    https_proxy = "http://#{http_proxy.host}:#{http_proxy.port}"
#  end
#
#  template = Erubis::Eruby.new <<-EOS.strip_heredoc
#    {
#  <% if http_proxy -%>
#      "proxy": "#{http_proxy}",
#  <% end -%>
#  <% if https_proxy -%>
#      "https-proxy": "#{https_proxy}"
#  <% end -%>
#    }
#  EOS
#
#  if http_proxy || https_proxy
#
#    data = template.result(
#      http_proxy: http_proxy,
#      https_proxy: https_proxy,
#    )
#
#    step %Q(a file named ".bowerrc" with:), data
#  end
# end

Then(/^a presentation theme named "(.*?)" should exist( with default files\/directories created)?$/) do |name, default_files|
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

Before do
  @aruba_timeout_seconds = 120
end
