# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dephine/version'

Gem::Specification.new do |gem|
  gem.name          = "dephine"
  gem.version       = Dephine::VERSION
  gem.authors       = ["Sina Samavati"]
  gem.email         = ["contact@s1n4.com"]
  gem.summary       = %q{Google dictionary in terminal}
  gem.homepage      = "http://s1n4.com/dephine"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
