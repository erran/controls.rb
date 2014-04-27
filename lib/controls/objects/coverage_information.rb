module Controls
  # A representation of the CoverageInformation for SecurityControl or
  # Configuration coverage
  class CoverageInformation < Dish::Plate
    include Comparable

    # Allows for sorting of objects that have :coverage ({CoverageInformation})
    #
    # @return [Fixnum] returns one of the following based on the percent of
    #   assets that are covered -1 (less than `other`), 0 (equal to `other`),
    #   or 1 (greater than `other`)
    def <=>(other)
      return unless other.respond_to? :percent_covered
      percent_covered <=> other.percent_covered
    end

    # [review] - shouldn't this be covered by the Dish coercion?
    # @return [Boolean] true if the method is :percent_covered otherwise calls
    #   `Dish::Plate#method_missing`
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
