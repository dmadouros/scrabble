# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scrabble/version'

Gem::Specification.new do |spec|
  spec.name          = "scrabble"
  spec.version       = Scrabble::VERSION
  spec.authors       = ["David Madouros"]
  spec.email         = ["david.madouros@gmail.com"]
  spec.summary       = %q{Scrabble exercise}
  spec.description   = %q{Scrabble exercise}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
