module Controls
  # A representation of the threat vector API resource
  class ThreatVector < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }

    # @return [String] the title of the threat vector
    def to_s
      title
    end
  end
end
