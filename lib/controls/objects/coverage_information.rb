module Controls
  class CoverageInformation < Dish::Plate
    def to_s
      "#<#{self.class}: total: #{total}, covered: #{covered}, uncovered: #{uncovered}, percent_covered: #{percent_covered}>"
    end
  end
end
