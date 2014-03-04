require 'controls/objects'

module Controls
  # A module to encapsulate middleware customization
  module Response
    def self.parse(obj, path = nil)
      hash_or_array = JSON.parse(obj)

      if hash_or_array.is_a?(Hash) && hash_or_array.key?('message') && hash_or_array.key?('documentationUrl')
        type = Controls::Error
      end

      type ||=
        case path
        when %r(^(?:/\d.\d)?/coverage/security_controls)
          Controls::SecurityControlCoverage
        when /(configuration|event|guidance|prioritized_guidance|security_control|threat_vector|trend)s?$/
          Controls.const_get(Regexp.last_match[1].split('_').map(&:capitalize).join)
        when %r(^(?:/\d.\d)?\/(assessment|configuration|guidance|security_control|threat|threat_vector)s?)
          Controls.const_get(Regexp.last_match[1].split('_').map(&:capitalize).join)
        when /findings$/
          Controls::SecurityControlFinding
        # [todo] - these asset related endpoints are inconsisteny create a better regex?
        when %r(^(?:/\d.\d)?/assets/search)
          Controls::AssetCollection
        when /((?:applicable|miconfigured|uncovered|undefended)?_?asset)s$/
          Controls::AssetCollection
        when %r(^(?:/\d.\d)?/((?:applicable|miconfigured|uncovered|undefended)?_?asset)s/)
          Controls::Asset
        else
          Dish::Plate
        end

      Dish(hash_or_array, type)
    end
  end
end
