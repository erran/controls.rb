require 'controls/objects/coverage_information'

module Controls
  # A representation of the Configuration resource w/ coverage information
  class Configuration < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :coverage, Controls::CoverageInformation

    # The title of the configuration
    #
    # @return [String]
    def to_s
      title
    end
  end
end
