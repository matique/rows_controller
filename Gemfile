source "https://rubygems.org"

version = ENV["RAILS_VERSION"]
gem 'rails', version ? "~> #{version}" : ">= 4.0.0"

gem 'slim'

group :test do
  gem 'capybara'
  gem 'rspec-rails'
end

group :development, :test do
  gem 'sqlite3'
  gem 'watchr'
  gem 'spork'
  gem 'simplecov', require: false
end
