require 'controls'
require_relative './matchers.rb'

module SpecHelpers
  def login_to_environment
    # Allow self-signed certs in continuous integration
    Controls.verify_ssl = false
    Controls.login(ENV['CONTROLS_USERNAME'], ENV['CONTROLS_PASSWORD'])
  end
end

RSpec.configure do |rspec|
 rspec.include SpecHelpers
end
