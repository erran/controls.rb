module Controls
  class Client
    # A module to encapsulate API methods related to assets
    # @since API v1.0
    # @version v1.0.0
    module Assets
      # @!group Asset Methods

      # [todo] - use @overload here for assets(params) vs assets(uuid) vs assets({ uuid: 'uuid-string', other: 'param' })
      # @note since the uuid is an optional param it has been added to the
      #   params options hash
      # @raise [Controls::NotFound] if the uuid didn't match any assets
      # @return [Hash] a hash representing the matching asset
      def assets(params = {})
        if params.is_a? Hash
          uuid = params.delete(:uuid)
        else
          uuid = params
          params = {}
        end

        if uuid && !uuid.empty?
          get "/assets/#{uuid}", params
        else
          get '/assets', params
        end
      end

      # [todo] - change the name to asset_search/search_assets?
      # @param [String] query the query to retreive assets for
      # @param [Hash] params the option hash to be turned into query parameters
      # @return [Hash] a hash representing the matching assets
      def asset_search(query, params = {})
        params[:query] = query
        get "/assets/search", params
      end

      # @param [String] guidance the guidance name to search by
      # @return [Array<Hash>] an array of hashes that represent assets
      def applicable_assets(guidance, params = {})
        get "/guidance/#{guidance}/applicable_assets", params
      end
      alias_method :assets_by_guidance, :applicable_assets

      # @param [String] configuration the name of the configuration to search by
      # @return [Array<Hash>] an array of hashes that represent assets
      def misconfigured_assets(configuration, params = {})
        get "/configurations/#{configuration}/misconfigured_assets", params
      end
      alias_method :assets_by_configuration, :misconfigured_assets

      # @param [String] threat the threat name to search by
      # @return [Array<Hash>] an array of hashes that represent assets
      def threat_assets(threat, params = {})
        fail NotImplementedError, "Assets by threat is not a valid request. Use Controls::Client#assets or Controls::Client#assets_by_threat_vector instead."
        # get "/threats/#{threat}/assets", params
      end
      alias_method :assets_by_threat, :threat_assets

      # @param [String] security_control the name of the security control to
      #   search by
      # @return [Array<Hash>] an array of hashes that represent assets
      def uncovered_assets(security_control, params = {})
        get "/security_controls/#{security_control}/uncovered_assets", params
      end
      alias_method :assets_by_security_control, :uncovered_assets

      # @param [String] threat_vector the threat vectory to search by
      # @return [Array<Hash>] an array of hashes that represent assets
      def undefended_assets(threat_vector, params = {})
        get "/threat_vectors/#{threat_vector}/undefended_assets", params
      end
      alias_method :assets_by_threat_vector, :undefended_assets

      # @!endgroup
    end
  end
end
