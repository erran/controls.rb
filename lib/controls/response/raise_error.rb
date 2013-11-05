require 'controls/error'

module Controls
  module Response
    # A middleware plugin that hooks into the Faraday client used by this gem
    class RaiseError < Faraday::Response::Middleware
      private

      # Implements the {#on_complete} hook used by Faraday's middleware
      #
      # @raise [Controls::Error] a subclass of Controls::Error if any errors
      #   were encountered
      # @return [nil] if no error was found
      def on_complete(response)
        if error = Controls::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
