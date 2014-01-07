require 'faraday'
require 'json'
require 'nokogiri'
require 'controls/authentication'
require 'controls/configurable'
require 'controls/client/assessments'
require 'controls/client/assets'
require 'controls/client/guidance'
require 'controls/client/security_controls'
require 'controls/client/threats'
require 'controls/client/trends'
require 'controls/response'

module Controls
  # A class that handles interactions with the **controls**insight API
  class Client
    include Controls::Authentication
    include Controls::Configurable
    include Controls::Client::Assessments
    include Controls::Client::Assets
    include Controls::Client::Guidance
    include Controls::Client::SecurityControls
    include Controls::Client::Threats
    include Controls::Client::Trends

    # A few messages to show the user of Controls::Client in the case that a bad certificate is encountered
    SSL_WARNING = [
      'The API endpoint used a self-signed or invalid SSL certificate.',
      'To allow this connection temporarily use `Controls.verify_ssl = false`.',
      'See the Controls.rb wiki on GitHub for more information on SSL verification.'
    ]

    # Creates a new {Controls::Client} object
    #
    # @param [Hash] options the options to use when adding keys from
    #   {Controls::Configurable}
    def initialize(options = {})
      Controls::Configurable.keys.each do |key|
        value = options[key].nil? ? Controls.instance_variable_get(:"@#{key}") : options[key]
        instance_variable_set(:"@#{key}", value)
      end

      if options[:verify_ssl].nil?
        middleware.ssl[:verify] = if ENV['CONTROLS_VERIFY_SSL'].nil?
                                    true
                                  else
                                    !(ENV['CONTROLS_VERIFY_SSL'] =~ /false/)
                                  end
      else
        middleware.ssl[:verify] = !!options[:verify_ssl]
      end

      login_from_netrc unless authenticated?

      if basic_authenticated?
        middleware.basic_auth(@username, @password)
      end
    end

    # Whether the middleware is currently set to verify SSL connections
    def verify_ssl
      middleware.ssl[:verify].nil? || !!middleware.ssl[:verify]
    end

    # Sets the middleware to to verify the SSL on true, or disregard it on false
    #
    # @param [Boolean] verify whether to verify SSL or not
    def verify_ssl=(verify)
      middleware.ssl[:verify] = !!verify
    end

    # Censors the password from the output of {#inspect}
    #
    # @return [String] the censored data
    def inspect
      raw = super
      raw.sub!(/(@password=")#{@password}(")/, "\\1*********\\2") if @password

      raw
    end

    # A wrapper for GET requests
    #
    # @return [Array,Hash] an array or hash of parsed JSON data
    def get(path, params = {}, headers = {})
      headers = connection_options[:headers].merge(headers)
      url = URI.escape(File.join(api_endpoint, path))
      resp = middleware.get(url, params, headers)

      Response.parse(resp.body)
    rescue Faraday::Error::ConnectionFailed => e
      if e.message =~ /^SSL_connect/
        warn(*SSL_WARNING)
      else
        raise e
      end
    end


    # A wrapper for GET requests
    #
    # @return [Array,Hash] an array or hash of parsed JSON data
    def web_get(path, params = {}, headers = {})
      headers = connection_options[:headers].merge(headers)
      url = URI.escape(File.join(web_endpoint, path))
      resp = middleware.get(url, params, headers)

      Response.parse(resp.body)
    rescue Faraday::Error::ConnectionFailed => e
      if e.message =~ /^SSL_connect/
        warn(*SSL_WARNING)
      else
        raise e
      end
    end

    # A list of methods for API connections available to the {Controls::Client}
    #
    # @note Any methods defined in a child module will be returned.
    # @return [Array<Symbol>] the methods defined in {Controls::Client} that are API related
    def api_methods
      mods = Controls::Client.included_modules.map do |mod|
        if mod.to_s =~ /^Controls::Client::/
          mod
        end
      end

      mods.compact.map { |mod| mod.instance_methods(false) }.flatten.sort
    end

    # A set of references from the "documentation" API endpoint /api
    #
    # @param [String] version the API version to collect documentation from
    def references(version = '1.0')
      version = '1.0' unless version =~ /\d.\d/

       web_get "/api/#{version}"

       # [review] - Use Response#generate_ruby
      @references = Hash[Response.parse(resp.body).sort]
    rescue Faraday::Error::ConnectionFailed => e
      if e.message =~ /^SSL_connect/
        warn(*SSL_WARNING)
      else
        raise e
      end
    end

    # Compares {#options} or with the given options hash
    #
    # @param [Hash] opts whether the options are the same or different
    # @return whether the options are the same or different
    def same_options?(opts)
      opts.hash.eql? options.hash
    end

    %w[assessment asset configuration
       guidance security_control threat
       threat_vector].each do |predicate_method|
      pluralized_method = predicate_method.eql?('guidance') ? 'guidance' : "#{predicate_method}s"

      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{predicate_method}?(*args)         # def assessment?(*args)
          send(:#{pluralized_method}, *args)    #   assessments(*args)
        rescue Controls::NotFound => e          # rescue Controls::NotFound => e
          false                                 #   false
        end                                     # end
      RUBY
    end
  end
end
