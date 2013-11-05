require 'controls/client/prioritized_guidance'

module Controls
  class Client
    # A module to encapsulate API methods related to guidance
    # @since API v1.0
    # @version v1.0.0
    module Guidance
      include PrioritizedGuidance

      # @!group Guidance Methods

      # @param [String] name the name of the guidance to search for
      # @return [Hash] a hash representing the matching guidance
      def guidance(name)
        get "/guidance/#{name}"
      end

      # @!endgroup
    end
  end
end
