module Controls
  class Client
    # A module to encapsulate API methods related to coverage
    # @since API v1.0
    # [todo] - this version is obviously off
    # @version v1.0.0
    module Coverage
      # Either returns coverage for all security controls or one by name
      #
      # @param [String] security_control_name the security control to return coverage for
      # @return [Array<Controls::SecurityControlCoverage>,Controls::SecurityControlCoverage]
      def security_control_coverage(security_control_name = nil)
        if security_control_name
          get "/coverage/security_controls/#{security_control_name}"
        else
          get '/coverage/security_controls'
        end
      end
    end
  end
end
