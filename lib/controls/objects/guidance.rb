module Controls
  Guidance = Class.new(Dish::Plate)
  Guidance::Section = Class.new(Dish::Plate)
  Guidance::Reference = Class.new(Dish::Plate) do
    private
    def _allowed_keys
      %w[url]
    end
  end

  class Guidance
    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :references, Reference
    coerce :sections, Section

    def to_s
      title
    end
  end

  PrioritizedGuidance = Class.new(Guidance)
end
