# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'regexy/version'

Gem::Specification.new do |spec|
  spec.name          = 'regexy'
  spec.version       = Regexy::VERSION
  spec.authors       = ['Vladimir Tikhonov']
  spec.email         = ['vladimir@tikhonov.by']

  spec.summary       = 'Regexy is the collection of useful ruby regular expressions'
  spec.description   = 'Regexy contains a lot of common-use regular expressions and provides a friendly syntax to combine them.'
  spec.homepage      = 'https://github.com/vladimir-tikhonov/regexy'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'coveralls', '~> 0.7'
end
