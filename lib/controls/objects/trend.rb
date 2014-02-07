module Controls
  class Trend < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
  end
end
