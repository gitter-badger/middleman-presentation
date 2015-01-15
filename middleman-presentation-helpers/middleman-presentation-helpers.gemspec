# coding: utf-8
lib = File.expand_path('../../middleman-presentation-core/lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'middleman-presentation-core/version'
require 'middleman-presentation-core/ruby'

Gem::Specification.new do |spec|
  spec.name          = 'middleman-presentation-helpers'
  spec.version       = Middleman::Presentation::VERSION
  spec.authors       = ['Max Meyer']
  spec.email         = ['dev@fedux.org']
  spec.summary       = 'Helpers for middleman-presentation'
  spec.homepage      = 'https://github.com/maxmeyer/middleman-presentation'
  spec.license       = 'MIT'


  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = Middleman::Presentation::REQUIRED_RUBY_VERSION
end
