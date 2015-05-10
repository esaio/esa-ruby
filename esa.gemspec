# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'esa/version'

Gem::Specification.new do |spec|
  spec.name          = "esa"
  spec.version       = Esa::VERSION
  spec.authors       = ["fukayatsu"]
  spec.email         = ["fukayatsu@gmail.com"]
  spec.summary       = %q{[WIP] esa API v2 client library, written in Ruby}
  spec.description   = %q{([WIP] esa API v2 client library, written in Ruby}
  spec.homepage      = "https://github.com/esaio/esa-ruby/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", "~> 0.9"
  spec.add_runtime_dependency "faraday_middleware"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rspec-nc"
end
