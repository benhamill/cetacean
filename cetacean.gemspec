# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cetacean/version'

Gem::Specification.new do |spec|
  spec.name          = "cetacean"
  spec.version       = Cetacean::VERSION
  spec.authors       = ["Ben Hamill"]
  spec.email         = ["git-commits@benhamill.com"]
  spec.description   = %q{Operate HAL-based Hypermedia APIs in an object-oriented way.}
  spec.summary       = %q{Operate HAL-based Hypermedia APIs.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
end
