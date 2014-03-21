require 'controls/objects/coverage_information'

module Controls
  class SecurityControlCoverage < Dish::Plate
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :coverage, Controls::CoverageInformation

    def without_coverage
      Controls::SecurityControl.new(enabled: enabled, name: name)
    end

    def without_coverage!
      coverage_keys = @_original_hash.keys.reject do |key|
        %w[enabled name].include? key
      end

      coverage_keys.each do |key|
        @_original_hash.delete(key)
      end
    end

    def to_s
      title
    end
  end
end
