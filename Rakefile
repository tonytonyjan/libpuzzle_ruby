require 'rake/testtask'
Rake::TestTask.new

require 'rake/extensiontask'
Rake::ExtensionTask.new('puzzle_ext') do |ext|
  ext.ext_dir = 'ext'
end

require 'rubygems/package_task'
spec = Gem::Specification.load(File.join(__dir__, 'libpuzzle.gemspec'))
Gem::PackageTask.new(spec).define

task default: :test