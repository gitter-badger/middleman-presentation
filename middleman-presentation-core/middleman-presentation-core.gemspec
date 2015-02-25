# encoding: utf-8
lib = File.expand_path('../../middleman-presentation-core/lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'middleman-presentation-core/version'
require 'middleman-presentation-core/ruby'

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
  spec.required_ruby_version = Middleman::Presentation::REQUIRED_RUBY_VERSION

  spec.add_dependency 'middleman', '~> 3.3.5'
  spec.add_dependency 'middleman-sprockets', '~> 3.3.8'
  spec.add_dependency 'middleman-minify-html', '~>3.4.0'
  spec.add_dependency 'bundler'
  spec.add_dependency 'tzinfo', '>= 0.3.0'
  spec.add_dependency 'addressable', '~> 2.3.5'
  spec.add_dependency 'launchy', '~> 2.4.2'
  spec.add_dependency 'fedux_org-stdlib', '>= 0.11.16'
  spec.add_dependency 'rake', '~>10.0'
  spec.add_dependency 'rubyzip', '~> 1.1.6'
  spec.add_dependency 'liquid', '~>3.0.1'
  spec.add_dependency 'thor', '~> 0.19.1'
  spec.add_dependency 'erubis', '~>2.7.0'
  spec.add_dependency 'kramdown', '~>1.5.0'
  spec.add_dependency 'nokogiri', '~> 1.6.6'
  spec.add_dependency 'facter', '~>2.4.1'
  spec.add_dependency 'i18n', '~> 0.7.0'
  spec.add_dependency 'hirb', '~>0.7.3'
  spec.add_dependency 'rouge', '~>1.8.0'
  spec.add_dependency 'colorize', '~> 0.7.5'
  #  spec.add_dependency 'ptools', '>= 1.2.6'
end
