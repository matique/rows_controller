# require 'simplecov'
# SimpleCov.start do
#   add_filter 'test'
# end

require "combustion"
Combustion.path = "test/internal"
Combustion.initialize! :all

require 'rails/test_help'
require 'minitest/autorun'
require 'capybara/rails'

#class ActiveSupport::TestCase
#  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#  fixtures :all
#
#  # Add more helper methods to be used by all tests here...
#end

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('fixtures', __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.fixtures :all
end
