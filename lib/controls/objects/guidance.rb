module Controls
  Guidance = Class.new(Dish::Plate)
  Guidance::Reference = Class.new(Dish::Plate)
  Guidance::Section = Class.new(Dish::Plate)

  class Guidance
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :references, Reference
    coerce :sections, Section
  end

  PrioritizedGuidance = Class.new(Guidance)
end
