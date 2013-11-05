module Controls
  # A namespace for errors in the Controls module
  class Error < StandardError
    # @!attribute [r] error_message
    #   @return [String] the error message
    # @!attribute [r] error_status
    #   @return [Fixnum] the error message
    # @!attribute [r] error_json
    #   @return [Hash] the JSON body from the error message
    attr_reader :error_json
    attr_reader :error_message
    attr_reader :error_status

    # @raise [BadRequest,Unauthorized,NotFound,InternalServerError] a subclass
    #   of {Controls::Error}
    # @return [nil] if no error was raised
    def self.from_response(response)
      error = case response[:status].to_i
              when 302
                # TODO: Nexpose/ControlsInsight returns 302 when you either visit a
                # none existant path (Nexpose) or unauthenticated
                # (ControlsInsight).
                Found # if response[:body].empty?
              when 400 then BadRequest
              when 401 then Unauthorized
              when 404 then NotFound
              when 500 then InternalServerError
              end

      error.new(response) if error
    end

    # @return [self] generates an error and passes it to super
    def initialize(response = nil)
      @response = response
      super(generate_error)
    end

    private

    # @return [String] an error message to be used by {#generate_error}
    def response_message
      return @response_message if @response_message

      resp = @response[:response]

      if resp.headers['content-type']
        resp.headers['content-type'][/(\S+);charset=utf-8/i]
        html = Regexp.last_match && Regexp.last_match[1].eql?('text/html')
      end

      @response_message = if html
        doc = Nokogiri::XML.parse(resp.body)

        if doc.css('title').text.eql? 'ControlsInsight'
          message = ['message'].zip(doc.css('h1').map(&:text))
          reason = ['reason'].zip([doc.css('p').map(&:text)])
          Hash[message + reason]
        else
          Hash[doc.css('HR').children.map { |elem| elem.text.split(' ', 2) }]
        end
      else
        if resp.body.empty?
          @error_json = {}
        else
          @error_json = JSON.parse(resp.body)
          @error_message = @error_json['message']
          @error_status = @error_json['status'].to_i

          @error_json
        end
      end
    end

    # @return [String] the error message passed to super on {#initialize}
    def generate_error
      return unless @response

      message = "#{@response[:method]} ".upcase
      message << "#{@response[:url].path}"

      if response_message.is_a? Hash
        message << ": #{response_message['message']}\n" if response_message['message']

        if response_message['reason'].respond_to?(:join)
          message << response_message['reason'].join("\n")
        elsif response_message['reason']
          message << response_message['reason'].to_s
        end
      elsif response_message.is_a? String
        message << response_message
      else
        message << "#{@response[:status]} -"
        message << self.class.to_s.split('::', 2).last
      end

      message.strip
    end
  end

  # @!group Generic errors

  # TODO REVIEW: To be raised when a user hasn't explicitly supplied credentials or set up
  # any environment defaults.
  Unauthenticated = Class.new(StandardError)

  # @!endgroup

  # @!group HTTP errors

  # @return [Found] an error to be raised when a status code of 401 is
  #   returned by the API
  Found = Class.new(Error)

  # @return [Unauthorized] an error to be raised when a status code of 401 is
  #   returned by the API
  Unauthorized = Class.new(Error)

  # @return [BadRequest] an error to be raised when a status code of 400 is
  #   returned by the API
  BadRequest = Class.new(Error)

  # @return [NotFound] an error to be raised when a status code of 404 is
  #   returned by the API
  NotFound = Class.new(Error)

  # @return [InternalServerError] an error to be raised when a status code of
  # 500 is returned by the API
  InternalServerError = Class.new(Error)

  # @!endgroup
end
