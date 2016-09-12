# frozen_string_literal: true
require 'rake/testtask'
Rake::TestTask.new

require 'rake/extensiontask'
Rake::ExtensionTask.new('puzzle_ext') do |ext|
  ext.ext_dir = 'ext'
end

require 'rubygems/package_task'
spec = Gem::Specification.load(File.expand_path('../libpuzzle.gemspec', __FILE__))
Gem::PackageTask.new(spec).define

task default: [:compile, :test]
