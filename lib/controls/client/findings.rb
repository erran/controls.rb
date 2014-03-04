module Controls
  class Client
    # A module to encapsulate API methods related to assets
    # @since API v1.0
    # @version v1.0.0
    module Findings
      # @!group Security Control/Configuration Findings Methods

      # @param [String] uuid the UUID of the asset to retrieve findings for
      # @raise [Controls::NotFound] if the uuid didn't match any assets
      # @return [Hash] a hash representing the matching asset
      def assets(uuid, params = {})
        get "/assets/#{uuid}/findings", params
      end

      # @!endgroup
    end
  end
end
