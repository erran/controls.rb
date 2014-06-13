require 'controls/objects/guidance'

module Controls
  class Guidance
    # A object that represents the reference resource of a {Controls::Guidance}
    class Reference < Dish::Plate
      # Returns a string representing a guidance collection
      def to_s
        url ? "#{title}: (#{url})" : title
      end

      private

      # Ensures that calling url wouldn't raise a KeyError when {nil}
      #
      # @return [Array] the keys that are allowed to be {nil}
      def _allowed_keys
        %w[url]
      end
    end
  end
end
