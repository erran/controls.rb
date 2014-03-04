require 'controls/objects/configuration_finding'

module Controls
  class SecurityControlFinding < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :findings, Controls::ConfigurationFinding

    def to_s
      "#{name}: #{findings.map { |finding| "\n  #{finding}"  }.join}"
    end
  end
end
