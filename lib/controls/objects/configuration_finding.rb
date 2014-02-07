module Controls
  class ConfigurationFinding < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }

    def to_s
      "#{state}: #{reason.strip}"
    end
  end
end
