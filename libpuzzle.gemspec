# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'puzzle/version'

Gem::Specification.new do |spec|
  spec.name          = 'libpuzzle'
  spec.version       = Puzzle::VERSION
  spec.authors       = 'Jian Weihang'
  spec.email         = 'tonytonyjan@gmail.com'
  spec.summary       = 'A library to find similar pictures with libpuzzle'
  spec.description   = 'This is a C extension for libpuzzle to find similar pictures with easy API.'
  spec.homepage      = 'https://github.com/tonytonyjan/libpuzzle_ruby'
  spec.license       = 'MIT'
  spec.files         = Dir['lib/**/*.rb', 'ext/**/*.{h,c}']
  spec.extensions    = ['ext/extconf.rb']
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'rake-compiler', '~> 0.9.5'
  spec.add_development_dependency 'minitest', '~> 5.7.0'
  spec.add_development_dependency 'byebug', '~> 5.0.0' if RUBY_VERSION >= '2.0'
end
