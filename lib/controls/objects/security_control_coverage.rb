module Controls
  class SecurityControlCoverage < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
  end
end
