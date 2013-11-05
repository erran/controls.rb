module Controls
  # A module that holds authentication methods for {Controls::Client}
  module Authentication
    # @return [Boolean] whether the user is authenticated using Basic Auth
    def basic_authenticated?
      @username && @password
    end

    # @note the following aliases should become real methods once new methods
    #   of authentication become available such as token/OAuth authentication
    alias_method :authenticated?, :basic_authenticated?
    alias_method :user_authenticated?, :basic_authenticated?

    # @note this method should be updated if new methods for authentication
    #   become available.
    def login(username, password)
      middleware.basic_auth(username, password)
    end

    # @return [Boolean] whether the netrc file was successfully loaded, otherwise
    #   returns false and prints an error to STDERR
    def login_from_netrc
      return false unless netrc?

      require 'netrc'
      host =  URI.parse(api_endpoint).host
      creds = Netrc.read(File.expand_path(netrc_file))[host]

      if creds
        self.username = creds.shift
        self.password = creds.shift

        middleware.basic_auth(username, password)
      else
        warn "No credentials found for '#{host}' in '#{netrc_file}'."

        false
      end
    rescue LoadError
      warn 'You must install the netrc gem to login via netrc.',
           'Retry after running `gem install netrc`.'

      false
    end
  end
end
