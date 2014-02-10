require 'controls/objects/coverage_information'

module Controls
  class Configuration < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :coverage, Controls::CoverageInformation

    def to_s
      title
    end
  end
end
