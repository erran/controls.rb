module Controls
  class Trend < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }

    def to_s
      format('%05.2f', grade)
    end
  end
end
