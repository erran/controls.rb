module Controls
  class Client
    # A module to encapsulate API methods related to events
    # @since API v1.0
    # @version v1.6.0
    module Events
      # @!group Event Methods


      # Either returns a list of all events or all events by type
      #
      # @param [Hash] params the query parameters to send with the request
      # @option params [String] :filter (:all) the event type to filter by
      # @raise [Controls::NotFound] if the uuid didn't match any events
      # @return [Hash] a hash representing the matching event
      def events(params = {})
        get '/events', params
      end
    end
  end
end
