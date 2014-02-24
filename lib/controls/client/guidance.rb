module Controls
  class Client
    # A module to encapsulate API methods related to guidance
    # @since API v1.0
    # @version v1.0.0
    module Guidance
      # @!group Guidance Methods

      # @param [String] name the name of the guidance to search for
      # @return [Hash] a hash representing the matching guidance
      def guidance(name)
        get "/guidance/#{name}"
      end

      # @param [String] threat the threat name to search by
      # @return [Array<Hash>] an array of "guidance hashes"
      def guidance_by_threat(threat)
        get "/threats/#{threat}/guidance"
      end

      # @!endgroup
    end
  end
end
