module Controls
  # A module to hold configurable options to be used by other classes such as
  # the {Controls} eigenclass or the {Controls::Client} class
  module Configurable
    # @!attribute api_endpoint
    #   @return [String] the endpoint to connect to. default: https://nexpose.local:3780/insight/controls/api/1.0
    # @!attribute api_endpoint
    #   @return [String] the endpoint to connect to. default: https://nexpose.local:3780/insight/controls/api/1.0
    # @!attribute connection_options
    #   @return [Hash] the current connection options (headers, etc.)
    # @!attribute default_media_type
    #   @return [String] the default media type to send with requests. default: application/json
    # @!attribute middleware
    #   @return [Faraday::Connection] the middleware used to send requests
    # @!attribute netrc
    #   @return [Boolean] whether to use the netrc credentials to authentcicate with the **controls**insight API
    # @!attribute netrc_file
    #   @return [String] the path of the .netrc file to look for credentials in. default: ~/.netrc
    # @!attribute user_agent
    #   @return [String] the user agent to send with API requests. example: "controls/v1.0.0.beta (ruby; 2.0.0p247; [x86_64-darwin12.4.0]; Faraday v0.8.8)"
    # @!attribute username
    #   @return [String] the username to use for authentication
    # @!attribute web_endpoint
    #   @return [String] the endpoint to connect to. default: https://nexpose.local:3780/insight/controls
    attr_accessor :api_endpoint, :api_version, :connection_options,
                  :default_media_type, :middleware, :netrc, :netrc_file,
                  :user_agent, :username, :web_endpoint

    # @!attribute [w] password
    #   @return [String] the password specified on login
    attr_writer   :password

    class << self
      # @return [Array<Symbol>] a list of configurable keys
      def keys
        @keys ||= [
          :api_endpoint,
          :api_version,
          :connection_options,
          :default_media_type,
          :middleware,
          :netrc,
          :netrc_file,
          :password,
          :user_agent,
          :username,
          :web_endpoint
        ]
      end
    end

    # @yield [self]
    def configure
      yield self
    end

    def netrc?
      !!@netrc
    end

    # Configures {Controls::Configurable} to use options found in
    # {Controls::Default}
    #
    # @return [self]
    def setup
      Controls::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Controls::Default.options[key])
      end

      self
    end
    # NOTE: This method currently leaves some "updated defaults" intact
    # alias_method :reset!, :setup

    private

    # @return [Hash] a hash representation of the options mapping key names to
    #   their instance variable counterpart's value
    def options
      Hash[Controls::Configurable.keys.map { |key| [key, instance_variable_get(:"@#{key}")] }]
    end
  end
end
