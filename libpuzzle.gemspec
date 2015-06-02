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
  spec.add_development_dependency 'rake', '~> 0'
  spec.add_development_dependency 'rake-compiler', '~> 0'
  spec.add_development_dependency 'minitest', '~> 0'
  spec.add_development_dependency 'byebug', '~> 0'
end
