source "https://rubygems.org"
##gemspec

version = ENV["RAILS_VERSION"]
gem 'rails', version ? "~> #{version}" : '>= 4.1'

gem 'slim'

group :test do
  gem 'capybara'
  gem 'rspec-rails', '>= 3.1'
end

group :development, :test do
  gem 'sqlite3'
  gem 'watchr'
  gem 'spork'
  gem 'simplecov', require: false
end
