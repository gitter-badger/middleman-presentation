source 'https://rubygems.org'

group :middleman do
  gem 'middleman', '~>3.3.2'
  gem 'middleman-sprockets'
  gem 'middleman-livereload'
  gem 'wdm', '~> 0.1.0', platforms: [:mswin, :mingw]
  gem 'tzinfo-data', platforms: [:mswin, :mingw]
end

gem 'middleman-presentation', path: File.expand_path('../', __FILE__)
gem 'middleman-presentation-core', path: File.expand_path('../middleman-presentation-core', __FILE__), require: false
gem 'middleman-presentation-helpers', path: File.expand_path('../middleman-presentation-helpers', __FILE__), require: false

group :development, :test do
  gem 'middleman-presentation-simple_plugin', path: File.expand_path('../middleman-presentation-core/fixtures/middleman-presentation-simple_plugin', __FILE__), require: false

  gem 'stackprof'
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

  gem 'foreman', require: false
  gem 'github-markup'
  gem 'redcarpet', require: false
  gem 'tmrb', require: false
  gem 'yard', require: false
  gem 'inch', require: false
  gem 'license_finder', require: false
  gem 'filegen', require: false
  gem 'travis-lint', require: false
  gem 'command_exec', require: false
  gem 'rake', require: false
  gem 'launchy', require: false

  gem 'excon', require: false

  gem 'therubyracer'
  gem 'therubyrhino'

  gem 'rugged'
  gem 'addressable'
end

group :debug do
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug', require: false
  gem 'pry-doc', require: false
  gem 'pry-stack_explorer', require: false
  gem 'pry-rescue', require: false
  gem 'pry-exception_explorer', require: false
end
