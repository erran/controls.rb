module Controls
  # A object to represent the
  class Trend < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }

    # @return [String] the grade of the trend
    def to_s
      format('%05.2f', grade)
    end
  end
end
