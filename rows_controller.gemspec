lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rows/version"

Gem::Specification.new do |s|
  s.name        = 'rows_controller'
  s.version     = Rows::VERSION
  s.summary     = 'RowsController DRYs your controllers.'
  s.description = 'YourController < RowsController ( < ApplicationController).'
  s.authors     = ['Dittmar Krall']
  s.email       = ['dittmar.krall@matique.de']
  s.homepage    = 'http://matique.de'

  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY

  s.files         = `git ls-files -z`.split("\x0")
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 1'
  s.add_development_dependency 'rake', '~> 12'
  s.add_development_dependency 'appraisal', '~> 2'
#  s.add_development_dependency 'combustion', '~> 0'
end
