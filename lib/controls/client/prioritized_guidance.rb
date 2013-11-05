module Controls
  class Client
    # A module to encapsulate API methods related to guidance
    # @since API v1.0
    # @version v1.0.0
    module PrioritizedGuidance
      # @!group Prioritized Guidance Methods

      # @param [String] security_control the security control name to search by
      # @return [Array<Hash>] an array of "guidance hashes"
      def prioritized_guidance_by_security_control(security_control)
        get "/security_controls/#{security_control}/prioritized_guidance"
      end

      # @param [String] configuration the configuration name to search by
      # @return [Array<Hash>] an array of "guidance hashes"
      def prioritized_guidance_by_configuration(configuration)
        get "/configurations/#{configuration}/prioritized_guidance"
      end

      # @param [String] threat the threat name to search by
      # @return [Array<Hash>] an array of "guidance hashes"
      def prioritized_guidance_by_threat(threat)
        get "/threats/#{threat}/prioritized_guidance"
      end

      # @param [String] threat_vector the threat name to search by
      # @return [Array<Hash>] an array of "guidance hashes"
      def prioritized_guidance_by_threat_vector(threat_vector)
        get "/threat_vectors/#{threat_vector}/prioritized_guidance"
      end
    end
  end
end
