# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dirwait/version'

Gem::Specification.new do |spec|
  spec.name          = "dirwait"
  spec.version       = DirWait::VERSION
  spec.authors       = ["J. Brandt Buckley"]
  spec.email         = ["brandt@runlevel1.com"]
  spec.summary       = %q{Watch and wait for a directory to be created}
  spec.description   = %q{Listens to filesystem event notifications until a specified directory is created and then exits.}
  spec.homepage      = "https://github.com/brandt/dirwait"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency "listen", "~> 2.4.0"
end
