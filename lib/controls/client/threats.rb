require 'controls/client/threat_vectors'

module Controls
  class Client
    # A module to encapsulate API methods related to threats and threat vectors
    # @since API v1.0
    # @version v1.0.0
    module Threats
      include ThreatVectors

      # @!group Threat Methods

      # @param [String] threat the threat name to search for
      # @return [String] a hash representing the specified threat
      def threats(threat = nil)
        if threat
          get "/threats/#{threat}"
        else
          get '/threats'
        end
      end

      # @!endgroup
    end
  end
end
