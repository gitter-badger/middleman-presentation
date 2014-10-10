source 'https://rubygems.org'

group :middleman do
  gem 'middleman', '~>3.3.2'
  gem 'middleman-sprockets'
  gem 'middleman-livereload'
  gem 'wdm', '~> 0.1.0', platforms: [:mswin, :mingw]
  gem 'tzinfo-data', platforms: [:mswin, :mingw]
end

group :middleman_presentation do
  gem 'middleman-presentation', path: File.expand_path('../', __FILE__)
  gem 'mp-core', path: File.expand_path('../mp-core', __FILE__), require: 'middleman-presentation-core'
  gem 'mp-helpers', path: File.expand_path('../mp-helpers', __FILE__), require: 'middleman-presentation-helpers'
end

group :development, :test do
  gem 'rspec', require: false
  gem 'fuubar', require: false
  gem 'simplecov', require: false
  gem 'rubocop', '>= 0.25.0', require: false
  gem 'coveralls', require: false
  gem 'cucumber', require: false
  gem 'aruba'
  gem 'bundler', require: false
  gem 'erubis'
  gem 'versionomy', require: false
  gem 'activesupport', require: false
  gem 'awesome_print', require: 'ap'

  gem 'mutant', require: false
  gem 'mutant-rspec', require: false

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
