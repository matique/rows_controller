#!/usr/bin/env rake

require "rubygems"

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

rails_version = `rails -v`.strip
rails_version =~ /Rails (\d*)\./
dir = "dummy#{$1}"
APP_RAKEFILE = File.expand_path("../test/#{dir}/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

load 'rails/tasks/statistics.rake'

Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test
