require 'controls/version'

module Controls
  # Default options merged with environment specific overrides to satisfy the
  # options specified in the {Controls::Configurable} module
  module Default
    # @return [String] the API version to connect to. default: 1.0
    # @since API v1.0.0
    API_VERSION = '1.0'.freeze

    # @return [String] the API endpoint to connect to. default: https://nexpose.local:3780/insight/controls/api/1.0
    # @since API v1.0.0
    API_ENDPOINT = "https://localhost:3780/insight/controls/api/#{API_VERSION}".freeze

    # @return [String] the default media type to send with requests. default: application/json
    # @since API v1.0.0
    MEDIA_TYPE = 'application/json'

    # @return [String] the user agent to send with API requests. example: "controls/v1.0.0.beta (ruby; 2.0.0p247; [x86_64-darwin12.4.0]; Faraday v0.8.8)"
    USER_AGENT = "controls/v#{Controls::VERSION} (#{(RUBY_DESCRIPTION.split[0..1] + [RUBY_DESCRIPTION.split.last]).join('; ')}; Faraday v#{Faraday::VERSION})".freeze

    # @return [String] the web endpoint to connect to. default: https://nexpose.local:3780/insight/controls
    WEB_ENDPOINT = 'https://localhost:3780/insight/controls'.freeze

    class << self
      # @return [Hash] options as a Hash, mapped by keys from {Controls::Configurable}
      def options
        Hash[Controls::Configurable.keys.map { |key| [key, send(key)] }]
      end

      # @return [String] the API endpoint's URI as a URL
      def api_endpoint
        endpoint = ENV['CONTROLS_API_ENDPOINT'] || API_ENDPOINT
        URI.parse(endpoint).to_s
      end

      # @return [String] the API version to connect to
      def api_version
        if ENV['CONTROLS_API_VERSION'].to_s =~ /\d+.\d+/
          ENV['CONTROLS_API_VERSION']
        else
          API_VERSION
        end
      end

      # @return [Hash] the current connection options (headers, etc.)
      def connection_options
        {
          headers: {
            accept: default_media_type,
            user_agent: user_agent
          }
        }
      end

      # @return [String] the environment specific default media type.
      #   default: {MEDIA_TYPE}
      def default_media_type
        ENV['CONTROLS_MEDIA_TYPE'] || MEDIA_TYPE
      end

      # REVIEW: Ensure that middleware is unique to the client instance
      # @return [Faraday::Connection] the middleware used to send requests
      def middleware
        @middleware ||= Faraday.new(api_endpoint, connection_options) do |conn|
          conn.adapter Faraday.default_adapter
          conn.response :logger if ENV['CONTROLS_DEBUG']
          conn.use Controls::Response::RaiseError
        end
      end

      # @return [Boolean] whether to fallback on authentication using the
      #   specified netrc file
      def netrc
        ENV['CONTROLS_NETRC'] || false
      end

      # @return [String] the netrc file to use for authentication.
      #   default: ~/.netrc
      def netrc_file
        ENV['CONTROLS_NETRC_FILE'] || File.join(Dir.home, '.netrc')
      end


      # @return [String] the password to use for authentication
      def password
        ENV['CONTROLS_PASSWORD']
      end

      # @return [String] the user agent that will be sent along any requests
      #   sent using {#connection_options}
      def user_agent
        ENV['CONTROLS_USER_AGENT'] || USER_AGENT
      end

      # @return [String] the username to use for authentication
      def username
        ENV['CONTROLS_USERNAME']
      end

      # @return [String] the web endpoint's URI as a URL
      def web_endpoint
        endpoint = ENV['CONTROLS_WEB_ENDPOINT'] || WEB_ENDPOINT
        URI.parse(endpoint).to_s
      end
    end
  end
end
