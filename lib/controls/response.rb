require 'controls/objects'

module Controls
  # A module to encapsulate middleware customization
  module Response
    def self.parse(obj, path = nil)
      type =
        case path
        when %r(^(?:/\d.\d)?/coverage/security_controls)
          Controls::SecurityControlCoverage
        when /(asset|configuration|event|guidance|prioritized_guidance|security_control|threat_vector|trend|(?:applicable|miconfigured|uncovered|undefended)_asset)s?$/
          Controls.const_get(Regexp.last_match[1].split('_').map(&:capitalize).join)
        when %r(^(?:/\d.\d)?\/(assessment|asset|configuration|threat|threat_vector)s)
          Controls.const_get(Regexp.last_match[1].split('_').map(&:capitalize).join)
        else
          Dish::Plate
        end

      hash_or_array = JSON.parse(obj)
      Dish(hash_or_array, type)
    end
  end
end
