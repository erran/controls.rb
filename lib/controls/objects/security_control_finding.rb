require 'controls/objects/configuration_finding'

module Controls
  class SecurityControlFinding < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :configurationFindings, Controls::ConfigurationFinding

    def to_s
      "#{security_control_name}: #{configuration_findings.map { |finding| "\n  #{finding}"  }.join}"
    end
  end
end
