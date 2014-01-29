lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rows_controller/version'

Gem::Specification.new do |s|
  s.name        = "rows_controller"
  s.version     = Rows::VERSION
  s.licenses    = ['MIT']
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Rows DRYs your controllers."
  s.description = "YourController < RowsController ( < ApplicationController)."
  s.authors     = ['Dittmar Krall']
  s.email       = ['dittmar.krall@matique.de']
  s.homepage    = 'http://matique.de'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"

  s.add_development_dependency 'sqlite3', '~> 0'  # for testing
  s.add_development_dependency 'rspec-rails', '~> 0'
  s.add_development_dependency 'capybara', '~> 0'
end
