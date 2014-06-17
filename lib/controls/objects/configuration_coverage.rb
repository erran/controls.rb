require 'controls/objects/coverage_information'

module Controls
  # A representation of the Configuration resource with coverage information
  class ConfigurationCoverage < Dish::Plate
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

    # [review] - define this in Dish?
    def respond_to?(method_name, *)
      if method_name.eql? :coverage
        true
      else
        super
      end
    end

    # Converts the object into a {Controls::Configuration} by name and
    # whether it is enabled/disabled
    #
    # @return {Controls::Configuration}
    def without_coverage
      Controls::Configuration.new(enabled: enabled, name: name)
    end

    # Removes the coverage from the {ConfigurationCoverage} object, making it
    # equivalent to a {Configuration} in terms of duck-typing
    #
    # @return {Controls::Configuration}
    def without_coverage!
      @_original_hash.delete_if do |key, _value|
        !%w(enabled name).include?(key)
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
