# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mcjsonapi/version'

Gem::Specification.new do |spec|
  spec.name          = "mcjsonapi"
  spec.version       = Mcjsonapi::VERSION
  spec.authors       = ["elomatreb"]
  spec.email         = ["elomatreb@googlemail.com"]
  spec.summary       = "A gem to interact with a Minecraft server running the JSONAPI plugin."
  spec.description   = <<-EOF
    A gem to interact with a Minecraft (bukkit) server that has the 
    {JSONAPI plugin}[https://github.com/alecgorge/jsonapi] installed. It supports
    calling single and multiple methods.
  EOF
  spec.homepage      = "https://github.com/elomatreb/mcjsonapi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
