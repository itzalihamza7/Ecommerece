# frozen_string_literal: true

require_relative '../config/environment'
require 'spec_helper'
require 'wisper/rspec/matchers'
require 'rspec/rails'
ENV['RAILS_ENV'] ||= 'test'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include(Wisper::RSpec::BroadcastMatcher)
  config.use_transactional_fixtures = true
  config.include FactoryBot::Syntax::Methods
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
