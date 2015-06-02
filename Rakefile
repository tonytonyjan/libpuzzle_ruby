require 'rake/extensiontask'
require 'rake/testtask'

Rake::TestTask.new

Rake::ExtensionTask.new('puzzle_ext') do |ext|
  ext.ext_dir = 'ext'
end

task default: :test