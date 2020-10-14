# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fog/k5/version'

Gem::Specification.new do |spec|
  spec.name          = 'fog-k5'
  spec.version       = Fog::K5::VERSION
  spec.authors       = ['blooper05']
  spec.email         = ['legend.of.blooper@gmail.com']

  spec.summary       = "Module for the 'fog' gem to support FUJITSU Cloud Service K5."
  spec.description   = 'This library can be used as a module for `fog` or as standalone provider to use the FUJITSU Cloud Service K5 in applications.'
  spec.homepage      = 'https://github.com/blooper05/fog-k5'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'fog-core'
  spec.add_dependency 'fog-json'

  spec.add_development_dependency 'bundler', '>= 1.16', '< 3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.13'

  spec.add_development_dependency 'github_changelog_generator'
  spec.add_development_dependency 'rubocop'
end
