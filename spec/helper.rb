require 'rspec'
require 'controls'

require 'vcr'
VCR.configure do |vcr|
  vcr.filter_sensitive_data('<CONTROLS_USERNAME>') do
    ENV['CONTROLS_TEST_USERNAME'] ||= ENV['CONTROLS_TEST_USERNAME']
  end

  vcr.filter_sensitive_data('<CONTROLS_PASSWORD>') do
    ENV['CONTROLS_TEST_PASSWORD'] ||= ENV['CONTROLS_TEST_PASSWORD']
  end

  vcr.filter_sensitive_data('https://nexpose.local:3780') do
    uri = URI.parse(Controls.client.web_endpoint)
    "#{uri.scheme}://#{uri.host}:#{uri.port}"
  end

  vcr.filter_sensitive_data('<CONTROLS_PASSWORD>') do
    ENV['CONTROLS_TEST_PASSWORD'] ||= ENV['CONTROLS_TEST_PASSWORD']
  end

  vcr.default_cassette_options = {
    record: ENV['CI'] ? :none : :once,
    serialize_with: :json
  }

  vcr.cassette_library_dir = 'spec/cassettes'
  vcr.hook_into :faraday
end

def test_controls_username
  ENV.fetch 'CONTROLS_TEST_USERNAME'
end

def test_controls_password
  ENV.fetch 'CONTROLS_TEST_PASSWORD'
end

def token_auth_client(user = test_controls_username, pass = test_controls_password)
  Controls.client.new(username: user, password: pass)
end
