module Controls
  class Assessment < Dish::Plate
    coerce :timestamp, ->(value) { Time.at(value / 1000) if value }

    def to_s
      id.to_s
    end
  end
end
