module Controls
  class Client
    # A module to encapsulate API methods related to security controls and
    # configurations
    # @since API v1.0
    # @version v1.0.0
    module Configurations
      # @!group Configuration Methods

      # @param [String] control the security control look up configurations for
      # @return [Array<Hash>] a list of hashes representing configurations
      def security_control_configurations(control)
        get "/security_controls/#{control}/configurations"
      end
      alias_method :configurations_by_security_control, :security_control_configurations

      # @!endgroup
    end
  end
end
