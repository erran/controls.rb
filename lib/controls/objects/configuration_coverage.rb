require 'controls/objects/coverage_information'

module Controls
  # A representation of the Configuration resource with coverage information
  class ConfigurationCoverage < Dish::Plate
    include Comparable

    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :coverage, Controls::CoverageInformation

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

    def without_coverage
      Controls::Configuration.new(enabled: enabled, name: name)
    end

    def without_coverage!
      @_original_hash.delete_if do |key, _value|
        not %w[enabled name].include?(key)
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
