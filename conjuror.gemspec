# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'conjuror/version'

Gem::Specification.new do |spec|
  spec.name          = "conjuror"
  spec.version       = Conjuror::VERSION
  spec.authors       = ["Nikhil Gupta"]
  spec.email         = ["me@nikhgupta.com"]
  spec.description   = %q{Easy Configuration for Standalone Ruby Scripts.}
  spec.summary       = %q{Easy Configuration for Standalone Ruby Scripts.}
  spec.homepage      = "http://github.com/nikhgupta/conjuror"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
