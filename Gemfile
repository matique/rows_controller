source "https://rubygems.org"

version = ENV["RAILS_VERSION"]
gem 'rails', version ? "~> #{version}" : '>= 4.1'

gem 'slim'

group :test do
  gem 'minitest-spec-rails'
  gem 'minitest-capybara'
  gem 'capybara'
end

group :development, :test do
  gem 'sqlite3'
  gem 'watchr'
  gem 'simplecov', require: false
end

gemspec
