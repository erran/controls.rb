module Controls
  # A representation of the Assessment resource
  class Assessment < Dish::Plate
    coerce :timestamp, ->(value) { Time.at(value / 1000) if value }

    # The assessment ID as a string
    def to_s
      id.to_s
    end
  end
end
