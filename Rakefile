#!/usr/bin/env rake
require "bundler/gem_tasks"
 
require 'rake/testtask'
 
Rake::TestTask.new do |t|
  t.libs << 'lib/buergel'
  t.test_files = FileList['test/lib/buergel/*_test.rb']
  t.verbose = true
end
 
task :default => :test


desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r buergel.rb"
end