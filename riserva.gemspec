# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riserva/version'

Gem::Specification.new do |spec|
  spec.name          = 'riserva'
  spec.version       = Riserva::VERSION
  spec.authors       = ['Igor Malinovskiy']
  spec.email         = ['psy.ipm@gmail.com']

  spec.summary       = 'Backup files to cloud drive'
  spec.homepage      = 'https://github.com/psyipm/riserva'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables << 'riserva'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.7', '>= 4.7.3'
  spec.add_development_dependency 'wisper-rspec', '~> 0.0.3'

  spec.add_runtime_dependency 'activesupport', '~> 4.0'
  spec.add_runtime_dependency 'choice', '~> 0.2.0'
  spec.add_runtime_dependency 'dropbox_api', '~> 0.1.7'
  spec.add_runtime_dependency 'dropbox_content_hasher', '~> 0.1.0'
  spec.add_runtime_dependency 'google_drive', '~> 2.1', '>= 2.1.5'
  spec.add_runtime_dependency 'notifier', '~> 0.5.2'
  spec.add_runtime_dependency 'safe_yaml', '~> 1.0', '>= 1.0.4'
  spec.add_runtime_dependency 'wisper', '~> 2.0'
end
