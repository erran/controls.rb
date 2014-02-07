require 'controls/client'
require 'controls/default'

# A Ruby client for the **controls**insight API
module Controls
  Error = Class.new(StandardError)

  class << self
    include Controls::Configurable

    # A {Client} object that includes {Configurable}
    #
    # @return [Client] the current {Client} object or a newly initialized
    #   {Client} object
    def client
      unless defined?(@client) && @client.same_options?(options)
        @client = Controls::Client.new(options)
      end

      @client
    end

    # @yield [client]
    def configure
      yield client
    end

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private)
    end

    private

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        client.send(method_name, *args, &block)
      else
        super
      end
    end
  end
end

Controls.setup
