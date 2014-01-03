# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buergel/version'

Gem::Specification.new do |spec|
  spec.name          = "buergel"
  spec.version       = Buergel::VERSION
  spec.authors       = ["Mathias Fiedler"]
  spec.email         = ["mathias@musterdenker.de"]
  spec.description   = %q{Adapter for the Bürgel BWI-Remote Connection Service }
  spec.summary       = %q{Still missing ...}
  spec.homepage      = "https://github.com/modomoto/buergel"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'iso_country_codes'
  spec.add_dependency 'gyoku'
  spec.add_dependency 'crack'
  spec.add_dependency 'typhoeus'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
