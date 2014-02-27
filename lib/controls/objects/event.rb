module Controls
  class Event < Dish::Plate
    coerce :createdAt, ->(value) { Time.at(value / 1000) if value }

    def payload
      value = _get_value('payload')
      Dish(value, Controls.const_get("#{type}Payload"))
    end

    def inspect
      super.sub('Event', type)
    end

    def to_s
      type
    end
  end
end
