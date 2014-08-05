ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
include Devise::TestHelpers

class ActiveSupport::TestCase

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  config.include Devise::TestHelpers, type: :controller

  # Add more helper methods to be used by all tests here...
end
