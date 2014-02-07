module Dish
  class Plate
    def method_missing(method, *args, &block)
      method = method.to_s
      camel_case_key = method.split('_').map(&:capitalize).join
      camel_case_key[0] = camel_case_key[0].downcase

      if method.end_with?('?')
        key = camel_case_key[0..-2]
        _check_for_presence(key)
      else
        _get_value(camel_case_key)
      end
    end
  end
end
