begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'


require 'rspec/core'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new(:spec)

Rake::TestTask.new do |t|
  t.libs.push 'test'
#  t.pattern = 'test/*_test.rb'
  t.pattern = 'test/**/*_test.rb'
end

desc 'Default: run unit tests.'
task :default => :test

desc "Clean automatically generated files"
task :clean do
  FileUtils.rm_rf "pkg"
end

desc "Check syntax"
task :syntax do
  Dir["**/*.rb"].each do |file|
    print "#{file}: "
    system("ruby -c #{file}")
  end
end
