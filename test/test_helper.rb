require 'simplecov'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'minitest/reporters'
require 'rails/test_help'
require 'database_cleaner'
require 'capybara/rails'
SimpleCov.start
Minitest::Reporters.use!
DatabaseCleaner.clean_with(:truncation)

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :minitest
    with.test_framework :minitest_4

    # Choose a library:
    with.library :active_record
    with.library :active_model
    with.library :action_controller
    # Or, choose all of the above:
    with.library :rails
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all
  include FactoryGirl::Syntax::Methods
  include Capybara::DSL
  ActiveRecord::Migration.check_pending!
  DatabaseCleaner.strategy = :deletion
  include FactoryGirl::Syntax::Methods
  setup {
    DatabaseCleaner.start
  }

  teardown {
    DatabaseCleaner.clean
  }
end
