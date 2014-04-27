require 'controls/objects/coverage_information'

module Controls
  # A representation of the Configuration resource w/ coverage information
  class Configuration < Dish::Plate
    include Comparable

    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :coverage, Controls::CoverageInformation

    # Allows for comparison with other objects with coverage information
    #
    # @return [Fixnum] returns one of the following based on the percent of
    #   assets that are covered -1 (less than `other`), 0 (equal to `other`),
    #   or 1 (greater than `other`)
    def <=>(other)
      return unless other.respond_to? :coverage
      coverage.percent_covered <=> other.coverage.percent_covered
    end

    # [review] - shouldn't this be covered by the Dish coercion?
    # @return [Boolean] true if the method is :coverage otherwise calls
    #   `Dish::Plate#method_missing`
    def respond_to?(method_name, *)
      if method_name.eql? :coverage
        true
      else
        super
      end
    end

    # The title of the configuration
    #
    # @return [String]
    def to_s
      title
    end
  end
end
