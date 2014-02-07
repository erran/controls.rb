module Controls
  class Assessment < Dish::Plate
    coerce :timestamp, ->(value) { Time.at(value / 1000) if value }
  end
end
