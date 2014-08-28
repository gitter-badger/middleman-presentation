# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman/presentation/helpers/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman-presentation-helpers"
  spec.version       = Middleman::Presentation::Helpers::VERSION
  spec.authors       = ["Max Meyer"]
  spec.email         = ["dev@fedux.org"]
  spec.summary       = %q{Helpers for middleman-presentation}
  spec.homepage      = "https://github.com/maxmeyer/middleman-presentation-helpers"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'middleman-presentation'
end
