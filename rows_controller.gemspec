lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rows/version"

Gem::Specification.new do |s|
  s.name = "rows_controller"
  s.version = Rows::VERSION
  s.summary = "RowsController DRYs your controllers."
  s.description = "YourController < RowsController ( < ApplicationController)."
  s.authors = ["Dittmar Krall"]
  s.email = ["dittmar.krall@matiq.com"]
  s.homepage = "https://github.com/matique/rows_controller"
  s.license = "MIT"
  s.platform = Gem::Platform::RUBY

  s.metadata["source_code_uri"] = "https://github.com/matique/rows_controller"

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "README.md"]
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "appraisal"
  s.add_development_dependency "combustion"

  s.add_development_dependency "minitest"
  # s.add_development_dependency "sqlite3"
end
