# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'static-data/version'

Gem::Specification.new do |spec|
  spec.name          = "static-data"
  spec.version       = StaticData::VERSION
  spec.authors       = ["Ben Turner"]
  spec.email         = ["codewrangler@outofcoffee.com"]
  spec.description   = %q{Rails plugin to manage static data in ActiveRecord 
      models/tables}
  spec.summary       = %q{StaticData is a Rails plugin that lets you easily 
      manage fixed data that you want to always have in your database, and 
      is primarily useful for pre-populating lookup tables and the like.}
  spec.homepage      = "https://github.com/kindjar/static-data"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rake"

  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
end
