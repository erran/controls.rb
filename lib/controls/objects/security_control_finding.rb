require 'controls/objects/configuration_finding'

module Controls
  # An object to represent the highest level of the finding API resources
  class SecurityControlFinding < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :findings, Controls::ConfigurationFinding

    # @return [String] a representation of the findings prefixed with the
    #   collection name
    def to_s
      "#{name}: #{findings.map { |finding| "\n  #{finding}"  }.join}"
    end
  end
end
