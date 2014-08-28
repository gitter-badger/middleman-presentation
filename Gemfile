source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'rspec', require: false
  gem 'rspec-legacy_formatters', require: false
  gem 'fuubar', require: false
  gem 'simplecov', require: false
  gem 'rubocop', require: false
  gem 'coveralls', require: false
  gem 'cucumber', require: false
  gem 'aruba'
  gem 'bundler', require: false
  gem 'erubis'
  gem 'versionomy', require: false
  gem 'activesupport', require: false
  gem 'awesome_print', require: 'ap'

  gem 'mutant'
  gem 'mutant-rspec'

  if !ENV.key?('CI') && !ENV.key?('TRAVIS')
    gem 'byebug'
    gem 'pry'
    gem 'pry-byebug', require: false
    gem 'pry-doc', require: false
  end

  gem 'foreman', require: false
  gem 'github-markup'
  gem 'redcarpet', require: false
  gem 'tmrb', require: false
  gem 'yard', require: false
  gem 'inch', require: false
  gem 'license_finder'
  gem 'filegen', require: false
  gem 'travis-lint', require: false
  gem 'command_exec', require: false
  gem 'rake', require: false
  gem 'launchy', require: false

  gem 'therubyracer'
  gem 'therubyrhino'
end
