require 'controls/objects/asset'

module Controls
  # A collection of Asset resources
  class AssetCollection < Dish::Plate
    include Enumerable

    coerce :resources, Asset

    def each(&block)
      return resources.enum_for(:each) unless block_given?

      resources.each(&block)
    end

    # Returns a comma separated list of IP addresses
    #
    # @return [String]
    def to_s
      resources.sort_by(&:ipaddress).map(&:to_s).join("\n")
    end

    def respond_to_missing?(method_name, include_private = false)
      super || resources.respond_to?(method_name, include_private)
    end

    private

    def method_missing(method_name, *args, &block)
      if resources.respond_to?(method_name)
        resources.send(method_name, *args, &block)
      else
        super
      end
    end
  end
end
