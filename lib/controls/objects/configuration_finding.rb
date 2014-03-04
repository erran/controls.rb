module Controls
  class ConfigurationFinding < Dish::Plate
    def to_s
      "#{name}: state: #{state} reason: #{reason.strip}"
    end
  end
end
