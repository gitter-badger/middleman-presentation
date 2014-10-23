# encoding: utf-8
$LOAD_PATH.push File.expand_path('../../middleman-presentation-core/lib', __FILE__)
require 'middleman-presentation-core/version'

Gem::Specification.new do |spec|
  spec.name                  = 'middleman-presentation'
  spec.version               = Middleman::Presentation::VERSION
  spec.platform              = Gem::Platform::RUBY
  spec.authors               = ['Max Meyer', 'Dennis Guennewig']
  spec.email                 = ['dev@fedux.org', 'dg1@vrnetze.de']
  spec.homepage              = 'https://github.com/maxmeyer/middleman-presentation'
  spec.summary               = 'Presentation engine for Middleman'

  spec.license               = 'MIT'
  spec.files                 = `git ls-files -z`.split("\x0")
  spec.executables           = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files            = spec.files.grep(%r{^(test|spec|features)/})

  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 2.1.0'

  spec.add_dependency 'middleman-presentation-core', spec.version
  spec.add_dependency 'middleman-presentation-helpers', '>= 0.0.6'
end
