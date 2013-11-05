module Controls
  class Client
    # A module to encapsulate API methods related to threats and threat vectors
    # @since API v1.0
    # @version v1.0.0
    module ThreatVectors
      # @!group Threat Vector Methods

      # @param [String] vector the threat vector to search for
      # @return [String] a hash representing the specified threat vector
      def threat_vectors(vector = nil)
        if vector
          get "/threat_vectors/#{vector}"
        else
          get '/threat_vectors'
        end
      end

      # @param [String] threat the threat to search for threat vectors by
      # @return [Array<Hash>] a list of hashes representing threats
      def threat_threat_vectors(threat)
        get "/threats/#{threat}/threat_vectors"
      end
      alias_method :threat_vectors_by_threat, :threat_threat_vectors

      # @!endgroup
    end
  end
end
