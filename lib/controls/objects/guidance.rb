module Controls
  # An object to represent the guidance resource returned by the
  # ControlsInsight API
  class Guidance < Dish::Plate
    # [review] - Is there another way to ensure a proper subclass setup?
    require 'controls/objects/guidance/reference'

    # A {Controls::Guidance} instance includes HTML markup in a sections list
    Section = Class.new(Dish::Plate)

    coerce :assessmentTimestamp, ->(value) { Time.at(value / 1000) if value }
    coerce :references, Reference
    coerce :sections, Section

    # @return [String] the title of the guidance
    def to_s
      title
    end
  end
end
