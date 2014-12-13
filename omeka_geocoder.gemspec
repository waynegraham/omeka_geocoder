# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omeka_geocoder/version'

Gem::Specification.new do |spec|
  spec.name          = "omeka_geocoder"
  spec.version       = OmekaGeocoder::VERSION
  spec.authors       = ["Wayne Graham"]
  spec.email         = ["wayne.graham@virginia.edu"]
  spec.summary       = %q{A Simple Geocoder for Omeka's NeatlineFeatures plugin}
  spec.homepage      = "https://github.com/waynegraham/omeka_geocoder"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "geocoder", "~> 1.2"
  spec.add_runtime_dependency "mechanize", "~> 2.7"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
