# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cear/version'

Gem::Specification.new do |spec|
  spec.name          = "cear"
  spec.version       = Cear::VERSION
  spec.authors       = ['Gaëtan JUVIN']
  spec.email         = ['gaetanjuvin@gmail.com']

  spec.summary       = %q{Ruby project generator.}
  spec.description   = %q{Ruby project generator.}
  spec.homepage      = 'https://github.com/GaetanJUVIN/mail'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ["cear"]
  spec.bindir        = "bin"
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.10"
  spec.add_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "actionpack", '~> 0'
  spec.add_runtime_dependency "activerecord", '~> 3'
  spec.add_runtime_dependency "colorize", '~> 0'
  spec.add_runtime_dependency "pry", '~> 0'
  spec.add_runtime_dependency "awesome_print", '~> 0'

  spec.post_install_message = "Super message"
end
