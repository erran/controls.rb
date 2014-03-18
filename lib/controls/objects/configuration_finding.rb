module Controls
  # A representation of the ConfigurationFinding resource
  class ConfigurationFinding < Dish::Plate
    # Returns the name, state, and reason data for the configuration finding
    #
    # "antivirus-installed: state: TRUE reason: Endpoint Security installed"
    def to_s
      "#{name}: state: #{state} reason: #{reason}"
    end
  end
end
