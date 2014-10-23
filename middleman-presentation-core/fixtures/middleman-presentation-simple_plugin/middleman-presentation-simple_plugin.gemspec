# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-presentation-simple_plugin/version'

Gem::Specification.new do |spec|
  spec.name          = 'middleman-presentation-simple_plugin'
  spec.version       = Middleman::Presentation::SimplePlugin::VERSION
  spec.authors       = ['blub']
  spec.email         = ['eamil@examlple.com']
  spec.summary       = 'Simple plugin fixture'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
end
