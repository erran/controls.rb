module Controls
  # A representation of the threat API resource
  class Threat < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }

    # @return [String] the title of the threat
    def to_s
      title
    end
  end
end
