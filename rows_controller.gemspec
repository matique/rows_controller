$:.push File.expand_path("../lib", __FILE__)

require "rows_controller/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rows_controller'
  s.version     = Rows::VERSION
  s.authors     = ['Dittmar Krall']
  s.email       = ['dittmar.krall@matique.de']
  s.homepage    = 'https://github.com/matique/rows_controller'
  s.summary     = 'RowsController DRYs your controllers.'
  s.description = 'YourController < RowsController ( < ApplicationController).'
  s.license     = 'MIT'

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.require_paths = ['lib']

  s.add_development_dependency 'sqlite3', '~> 0'
end
