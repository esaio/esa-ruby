# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'esa/version'

Gem::Specification.new do |spec|
  spec.name          = 'esa'
  spec.version       = Esa::VERSION
  spec.authors       = ['fukayatsu']
  spec.email         = ['fukayatsu@gmail.com']
  spec.summary       = 'esa API v1 client library, written in Ruby'
  spec.homepage      = 'https://github.com/esaio/esa-ruby/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '>= 0.9', '< 2.0'
  spec.add_runtime_dependency 'faraday_middleware', '>= 0.12', '< 2.0'
  spec.add_runtime_dependency 'mime-types', '>= 2.6', '< 4.0'
  spec.add_runtime_dependency 'multi_xml', '>= 0.5.5', '< 1.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'webmock', '~> 3.7.6'
end
