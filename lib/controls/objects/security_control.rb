module Controls
  # An object to represent the security control resource (without coverage)
  # returned by the ControlsInsight API
  class SecurityControl < Dish::Plate
    # @return [String] the name of the security control
    def to_s
      name
    end
  end
end
