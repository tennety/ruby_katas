# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'greed/version'

Gem::Specification.new do |gem|
  gem.name          = "greed"
  gem.version       = Greed::VERSION
  gem.authors       = ["TODO: Write your name"]
  gem.email         = ["TODO: Write your email address"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('aruba')
  gem.add_development_dependency('minitest')
  gem.add_development_dependency('pry')
  gem.add_development_dependency('ghpreview')
  gem.add_development_dependency('rake', '~> 0.9.2')
  gem.add_dependency('methadone', '~> 1.2.4')
end
