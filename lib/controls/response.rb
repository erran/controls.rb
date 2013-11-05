require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/hash/keys'
require 'controls/response/raise_error'

module Controls
  # A namespace for response related classes
  module Response
    # @param [String] response the response body as a JSON String provided by
    #   the ControlsInsight API
    # @return [Array,Hash] the response after being parsed into an Array or
    #   Hash
    def self.parse(response)
      response = JSON.parse(response)
    end

    # @param [Array,Hash] response the Array or Hash to convert into a ruby
    #  style object
    def self.generate_ruby(response)
      if response.is_a? String
        response = JSON.parse(response)
      end

      # TODO: Determine the specific format, or create a new, recursive (w/
      #       array support) deep method
      # NOTE: If the ControlsInsight API begins returning more complex JSON
      #       this conditional must be updated.
      if response.is_a? Hash
        response.deep_transform_keys! { |key| key.underscore }

        if response.has_key? 'resources'
          response['resources'].each do |hash|
            hash.deep_transform_keys! { |key| key.underscore }

            if hash.has_key? 'security_control_findings'
              hash['security_control_findings'].each do |subhash|
                subhash.deep_transform_keys! { |key| key.underscore }

                if subhash.has_key? 'configuration_findings'
                  subhash['configuration_findings'].each do |subhash_two|
                    subhash_two.deep_transform_keys! { |key| key.underscore }
                  end
                end
              end
            end
          end
        end
      elsif response.is_a? Array
        response.each do |element|
          if element.is_a? Hash
            element.deep_transform_keys! { |key| key.underscore }

            if element.has_key? 'resources'
              element['resources'].each do |hash|
                hash.deep_transform_keys! { |key| key.underscore }

                if hash.has_key? 'security_control_findings'
                  hash['security_control_findings'].each do |subhash|
                    subhash.deep_transform_keys! { |key| key.underscore }

                    if subhash.has_key? 'configuration_findings'
                      subhash['configuration_findings'].each do |subhash_two|
                        subhash_two.deep_transform_keys! { |key| key.underscore }
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end

      response
    end
  end
end
