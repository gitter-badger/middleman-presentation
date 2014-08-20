# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman/presentation/test/simple/version'

Gem::Specification.new do |spec|
  spec.name          = 'middleman-presentation-test-simple'
  spec.version       = Middleman::Presentation::Test::Simple::VERSION
  spec.authors       = ['blub']
  spec.email         = ['eamil@examlple.com']
  spec.summary       = %q(Simple plugin fixture)
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
end
