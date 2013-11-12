$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cetacean'

require 'webmock/rspec'
require 'pry'
require 'sinatra/base'
require 'faraday'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
  end
end

WebMock.disable_net_connect!

def stub_service(uri, stub, &block)
  uri = URI.parse(uri)
  port = uri.port != uri.default_port ? ":#{uri.port}" : ""
  stub = block ? Sinatra.new(stub, &block) : stub

  WebMock.stub_request(
    :any,
    %r{^#{uri.scheme}://(.*:.*@)?#{uri.host}#{port}/.*$}
  ).to_rack(stub)
end
