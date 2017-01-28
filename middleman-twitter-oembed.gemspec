# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman-twitter-oembed/version'

Gem::Specification.new do |spec|
  spec.name          = "middleman-twitter-oembed"
  spec.version       = Middleman::TwitterOembed::VERSION
  spec.authors       = ["Ataru Kodaka"]
  spec.email         = ["ataru.kodaka@gmail.com"]

  spec.summary       = %q{An extension for middleman to render twittr oembed status}
  spec.description   = %q{An extension for middleman to render twittr oembed status}
  spec.homepage      = "http://github.com/atarukodaka/middleman-twitter-oembed"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency("middleman", ">= 3.2")
  
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "cucumber", "~> 1.3"
  spec.add_development_dependency "aruba", "~> 0.6"
  spec.add_development_dependency "therubyracer", "~>0.12"
  spec.add_development_dependency "pry-byebug", "~>3.1"
  spec.add_development_dependency "rb-readline", "~>0.5"
  spec.add_development_dependency "middleman-pry", "~>0.0"
end
