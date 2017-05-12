#require 'simplecov'
#SimpleCov.start do
#  add_filter 'test'
#  command_name 'Minitest'
#end

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"


rails_version = `rails -v`.strip
aster = '#' * 20
puts "#{aster} Testing Ruby #{RUBY_VERSION}; #{rails_version} #{aster}"

rails_version =~ /Rails (\d*)\./
dir = "dummy#{$1}"


require File.expand_path("../#{dir}/config/environment.rb",  __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/#{dir}/db/migrate", __FILE__)]
require 'rails/test_help'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.fixtures :all
end
