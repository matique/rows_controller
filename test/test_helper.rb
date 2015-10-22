#require 'simplecov'
#SimpleCov.start do
#  add_filter 'test'
#  command_name 'Minitest'
#end


# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

# trick to find test/dummy...  environment
dir = "dummy"
# optimization: reduce calls to rails -v
arr = Dir["test/dummy*"]
if arr.length > 1
  major = `rails -v` =~ /Rails (\d)/
  str = "dummy#{$1}"
  dir = str  if File.exists?("test/#{str}")
p "************** test/#{dir} ************"
end

require File.expand_path("../../test/#{dir}/config/environment.rb",  __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/#{dir}/db/migrate", __FILE__)]
require "rails/test_help"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
##Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.fixtures :all
end
