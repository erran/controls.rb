module Controls
  # A class under the Controls namespace to wrap API errors
  class Error < StandardError
    # @!attribute message
    #   The message related to the error
    attr_accessor :message

    # @!attribute message
    #   The status code for the error response
    attr_accessor :status

    def initialize(attributes = {})
      attributes.each do |attribute, value|
        instance_variable_set(:"@#{attribute}", value)
      end
    end
  end
end
