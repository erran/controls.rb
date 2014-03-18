require 'controls/client'
require 'controls/default'

# A Ruby client for the **controls**insight API
module Controls
  # A class under the Controls namespace to wrap API errors
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

    # Yields the global client to configure in a block
    #
    # @yield [client]
    def configure
      yield client
    end

    # Overrides the respond_to_missing method to act as a proxy for
    # {Controls::Client}
    #
    # @param [Symbol,String] method_name the method name to check for
    # @param [Boolean] include_private to include private methods when checking for method response
    # @return [Boolean] whether {Controls} responds to the method
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
