# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'middleman-presentation/version'

Gem::Specification.new do |s|
  s.name = 'middleman-presentation'
  s.version = Middleman::Presentation::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Max Meyer']
  s.email = ['dev@fedux.org', 'ben@benhollis.net']
  s.homepage = 'https://github.com/maxmeyer/middleman-presentation'
  s.summary = %q{Presentation engine for Middleman}
  s.description = %q{Presentation engine for Middleman}

  s.license = 'MIT'
  s.files = `git ls-files -z`.split("\0")
  s.test_files = `git ls-files -z -- {fixtures,features}/*`.split("\0")
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'middleman', '~> 3.2'
  s.add_dependency 'tzinfo', '>= 0.3.0'
  s.add_dependency 'addressable', '~> 2.3.5'
  s.add_dependency 'launchy', '~> 2.4.2'
end
