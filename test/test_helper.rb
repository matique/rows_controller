## # Load fixtures from the engine
## if ActiveSupport::TestCase.method_defined?(:fixture_path=)
##   ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
## end

#require 'simplecov'
#SimpleCov.start do
#  add_filter 'test'
#  command_name 'Minitest'
#end


# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rails/test_help'
#require 'minitest/autorun'
#require "capybara/rails"

##Rails.backtrace_cleaner.remove_silencers#

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#
# Note: You'll currently still have to declare fixtures explicitly in integration tests
# -- they do not yet inherit this setting
  fixtures :all
# Add more helper methods to be used by all tests here...
end
