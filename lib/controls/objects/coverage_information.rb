module Controls
  # A representation of the CoverageInformation for SecurityControl or
  # Configuration coverage
  class CoverageInformation < Dish::Plate
    alias_method :to_s, :inspect
  end
end
