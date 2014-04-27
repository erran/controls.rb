module Controls
  # A class under the Controls namespace to wrap API errors
  #
  # [review] - subclass Dish::Plate instead of StandardError?
  class Error < StandardError
    # @!attribute [rw] message
    #   @return [String] the message related to the error
    # @!attribute [rw] status
    #   @return [String] the status code for the error response
    attr_accessor :message, :status

    # @param [Hash] attributes the key/value pairs to set instance variables
    #   with
    # @option :message [String] the error's associated message
    # @option :status [String] the error's associated status code
    # @return [self] the {Controls::Error} with the given attributes
    def initialize(attributes = {})
      @__attributes__ = attributes
      @__attributes__.each do |attribute, value|
        instance_variable_set(:"@#{attribute}", value)
      end
    end

    # @return [String] a string representing the error and all of it's
    #   attributes
    def inspect
      vars = to_h.map do |attribute, value|
        "#{attribute}: #{value}"
      end

      "#<#{self.class}: #{vars.join(', ')}>"
    end

    # @return [String] the JSON representation of the attributes
    def to_json
      @__attributes__.to_json
    end

    # @return [Hash] the attributes used to initialize this error
    def to_h
      @__attributes__
    end

    # @return [String] the error message if available otherwise calls {#inspect}
    def to_s
      @message or inspect
    end

    private

    # @!attribute [r] message
    #   @return [String] the message related to the error
    attr_reader :__attributes__
  end
end
