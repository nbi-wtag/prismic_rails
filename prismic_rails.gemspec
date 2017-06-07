# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prismic_rails/version'

Gem::Specification.new do |spec|
  spec.name          = "prismic_rails"
  spec.version       = PrismicRails::VERSION
  spec.authors       = ["Felix Langenegger"]
  spec.email         = ["f.langenegger@fadendaten.ch"]

  spec.summary       = %q{PrismicRails provides rails view helpers to query prismic.io.}
  spec.description   = %q{With PrismicRails it is simple to query the prismic.io API for a defined custom type. By providing rails helpers the integration in your rails view is much easier as before.}
  spec.homepage      = "https://github.com/fadendaten/prismic_rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "prismic.io", "~> 1.4.1"
  spec.add_runtime_dependency 'rails'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency "rdoc"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "faraday"
  spec.add_development_dependency "faraday_middleware"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "pry-doc"
  spec.add_development_dependency 'simplecov'
end
