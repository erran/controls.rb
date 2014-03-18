module Controls
  # A representation of the Event resource
  class Event < Dish::Plate
    coerce :createdAt, ->(value) { Time.at(value / 1000) if value }

    # Coerces the payload into the appropriate type
    #
    # @return [Controls::SecurityControlChangeEventPayload,Controls::SiteChangeEventPayload,Controls::ProductEventPayload]
    #   the payload respective of the event type
    def payload
      value = _get_value('payload')
      Dish(value, Controls.const_get("#{type}Payload"))
    end

    # Overrides #inspect to use the proper event type
    #
    # @return [String] the result of super with the corrected event type
    def inspect
      super.sub('Event', type)
    end

    # Returns the event type
    #
    # [todo] - is the type all we want to return?
    #
    # @return [string] the event type
    def to_s
      type
    end
  end
end
