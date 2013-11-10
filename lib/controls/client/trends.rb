module Controls
  class Client
    # A module to encapsulate API methods related to trends
    # @since API v1.0
    # @version v1.0.1
    module Trends
      # @!group Trending Methods

      # @param [String] configuration the name of the configuration for which
      #   to receive trending for
      # @return [Array<Hash>] a list of hashes representing trending data over
      #   time
      def configuration_trends(configuration)
        get "/configurations/#{configuration}/trend"
      end
      alias_method :trends_by_configuration, :configuration_trends

      # @param [String] threat the name of the threat for which
      #   to receive trending for
      # @return [Array<Hash>] a list of hashes representing trending data over
      #   time
      def threat_trends(threat)
        get "/threats/#{threat}/trend"
      end
      alias_method :trends_by_threat, :threat_trends

      # @param [String] threat_vector the name of the threat_vector for which
      #   to receive trending for
      # @return [Array<Hash>] a list of hashes representing trending data over
      #   time
      def threat_vector_trends(threat_vector)
        get "/threat_vectors/#{threat_vector}/trend"
      end
      alias_method :trends_by_threat_vector, :threat_vector_trends

      # @!endgroup
    end
  end
end
