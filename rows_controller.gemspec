lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rows/version'

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

  s.files = Dir['{app,lib}/**/*', 'MIT-LICENSE', 'README.md']
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake', '~> 13'
  s.add_development_dependency 'appraisal', '~> 2'
  s.add_development_dependency 'combustion', '~> 1.1'

  s.add_development_dependency 'minitest', '~> 5'
  s.add_development_dependency 'sqlite3', '~> 1'
end
