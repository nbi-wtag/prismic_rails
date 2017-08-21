require 'simplecov'
require "bundler/setup"
SimpleCov.start

require "prismic_rails"
require 'vcr'
require 'dotenv'
require 'webmock/rspec'

Dotenv.load

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |c|
    c.allow_message_expectations_on_nil = true
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassetts"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
  config.default_cassette_options = {
    match_requests_on: [:method, :path]
  }
end

PrismicRails.configure do |config|
  config.url = ENV.fetch("PRISMIC_API_URL", "")
  config.token = ENV.fetch("PRISMIC_ACCESS_TOKEN", nil)
end

WebMock.disable_net_connect!(allow_localhost: true)
