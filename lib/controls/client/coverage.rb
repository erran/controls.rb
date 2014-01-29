module Controls
  class Client
    module Coverage
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
