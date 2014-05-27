module Dish
  class Plate
    def methods(all = true)
      valid_keys = as_hash.keys.map do |key|
        key.to_s.gsub(/([^A-Z])([A-Z]+)/, '\1_\2').downcase.to_sym
      end

      valid_keys + super
    end

    def inspect
      hash = as_hash
      keys_to_snake_case = hash.keys.map { |key|
        [key, key.to_s.gsub(/([^A-Z])([A-Z]+)/, '\1_\2').downcase]
      }
      keys_to_snake_case = Hash[keys_to_snake_case]

      vars = hash.map do |key, value|
        "#{keys_to_snake_case[key]}: #{_get_value(key)}"
      end

      "#<#{self.class}: #{vars.join(', ')}>"
    end

    alias_method :to_h, :as_hash

    def to_json(*args)
      as_hash.to_json(*args)
    end

    private

    def _set_value(key, value)
      value = _convert_value(value, self.class.coercions[key])
      @_original_hash[key] = value
    end

    def method_missing(method, *args, &block)
      method = method.to_s
      camel_case_key = method.split('_').map(&:capitalize).join
      camel_case_key[0] = camel_case_key[0].downcase

      if method.end_with? '?'
        key = camel_case_key[0..-2]
        _check_for_presence(key)
      elsif method.end_with? '='
        key = camel_case_key[0..-2]
        _set_value(key, args.first)
      else
        if @_original_hash.key?(camel_case_key)
          _get_value(camel_case_key)
        else
          super(method.to_sym, *args, &block)
        end
      end
    end
  end
end
