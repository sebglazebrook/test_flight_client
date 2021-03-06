# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'test_flight_client/version'

Gem::Specification.new do |spec|
  spec.name          = "test_flight_client"
  spec.version       = TestFlightClient::VERSION
  spec.authors       = ["Seb Glazebrook"]
  spec.email         = ["me@sebglazebrook.com"]
  spec.summary       = %q{Ruby client for TestFlightApp developer API.}
  spec.description   = %q{Super simple ruby client for TestFlightApp's super simple developer API.}
  spec.homepage      = "https://github.com/sebglazebrook/test_flight_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httmultiparty'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'debugger'
end
