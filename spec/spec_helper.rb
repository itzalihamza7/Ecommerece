# frozen_string_literal: true

require 'simplecov'
require 'stripe_mock'

SimpleCov.start do
  add_filter '/test/'
  add_filter '/config/'
  add_filter '/vendor/'
  add_filter '/policies/'
  add_filter 'helper'
  add_filter '/concerns/'
  add_filter '/users_controller'
  add_filter '/application_controller'

  add_group 'Controllers', 'app/controllers/readers/suggestions_controller.rb'
  add_group 'Controllers', 'app/controllers/authors/posts_controller.rb'

  add_group 'Models', 'app/models'
end

RSpec.configure do |config|
  # config.before do
  #   @stripe_test_helper = StripeMock.create_test_helper
  #   StripeMock.start
  # end

  # config.after do
  #   StripeMock.stop
  # end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
