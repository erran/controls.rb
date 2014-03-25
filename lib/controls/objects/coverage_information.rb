module Controls
  # A representation of the CoverageInformation for SecurityControl or
  # Configuration coverage
  class CoverageInformation < Dish::Plate
    include Comparable

    def <=>(other)
      return unless other.respond_to? :percent_covered
      percent_covered <=> other.percent_covered
    end

    # [review] - define this in Dish?
    def respond_to?(method_name, *)
      if method_name.eql? :percent_covered
        true
      else
        super
      end
    end

    alias_method :to_s, :inspect
  end
end
