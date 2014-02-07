# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'controls/version'

Gem::Specification.new do |spec|
  spec.name          = 'controls'
  spec.version       = Controls::VERSION
  spec.authors       = ['Erran Carey']
  spec.email         = %w['me@errancarey.com']
  spec.description   = %q{This gem interfaces to Rapid7's **controls**insight API.}
  spec.summary       = %q{This gem interfaces to Rapid7's **controls**insight API.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w[lib]

  spec.add_dependency 'dish'
  spec.add_dependency 'faraday', '< 0.9'
  spec.add_dependency 'rack'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'netrc'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'yard'
end
