# encoding: utf-8
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'middleman-presentation-core/version'

Gem::Specification.new do |spec|
  spec.name                  = 'middleman-presentation-core'
  spec.version               = Middleman::Presentation::VERSION
  spec.platform              = Gem::Platform::RUBY
  spec.authors               = ['Max Meyer', 'Dennis Guennewig']
  spec.email                 = ['dev@fedux.org', 'dg1@vrnetze.de']
  spec.homepage              = 'https://github.com/maxmeyer/middleman-presentation'
  spec.summary               = 'Presentation engine for Middleman'

  spec.license               = 'MIT'
  spec.files                 = `git ls-files -z`.split("\x0") + Dir.glob('utils/server/*')
  spec.executables           = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files            = spec.files.grep(%r{^(test|spec|features)/})

  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 2.1.0'

  spec.add_dependency 'middleman', '~> 3.3.5'
  spec.add_dependency 'middleman-sprockets', '~> 3.3.8'
  spec.add_dependency 'bundler'
  spec.add_dependency 'tzinfo', '>= 0.3.0'
  spec.add_dependency 'addressable', '~> 2.3.5'
  spec.add_dependency 'launchy', '~> 2.4.2'
  spec.add_dependency 'fedux_org-stdlib', '>= 0.10.9'
  spec.add_dependency 'rake'
  spec.add_dependency 'rubyzip', '~> 1.1.6'
  spec.add_dependency 'liquid'
  spec.add_dependency 'erubis'
  spec.add_dependency 'kramdown'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'facter'
  spec.add_dependency 'i18n'
  spec.add_dependency 'hirb'
  spec.add_dependency 'rouge'
  #  spec.add_dependency 'ptools', '>= 1.2.6'
end
