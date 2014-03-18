module Controls
  # A class under the Controls namespace to wrap API errors
  #
  # [review] - subclass Dish::Plate instead of StandardError?
  class Error < StandardError
    # @!attribute message
    #   The message related to the error
    attr_accessor :message

    # @!attribute message
    #   The status code for the error response
    attr_accessor :status

    def initialize(attributes = {})
      @__attributes__ = attributes
      @__attributes__.each do |attribute, value|
        instance_variable_set(:"@#{attribute}", value)
      end
    end

    def to_h
      @__attributes__
    end

    def inspect
      vars = to_h.map do |attribute, value|
        "#{attribute}: #{value}"
      end

      "#<#{self.class}: #{vars.join(', ')}>"
    end

    def to_s
      @message or inspect
    end

    private

    attr_reader :__attributes__
  end
end
