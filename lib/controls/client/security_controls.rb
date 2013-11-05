require 'controls/client/configurations'

module Controls
  class Client
    # A module to encapsulate API methods related to security controls and
    # configurations
    # @since API v1.0
    # @version v1.0.0
    module SecurityControls
      include Configurations

      #!@group Security Control Methods

      # @param [String] control the name of the security control name to
      #   retrieve
      # @return [Hash] a hash representing a security control
      def security_controls(control = nil)
        if control
          get "/security_controls/#{control}"
        else
          get '/security_controls'
        end
      end

      # @param [String] vector the threat vector to search for securuty controls
      #   by
      # @return [Array<Hash>] a list of hashes representing threats
      def threat_vector_security_controls(vector)
        get "/threat_vectors/#{vector}/security_controls"
      end
      alias_method :security_controls_by_threat_vector, :threat_vector_security_controls

      # @!endgroup
    end
  end
end
