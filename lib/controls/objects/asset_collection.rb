require 'controls/objects/asset'

module Controls
  # A collection of Asset resources
  class AssetCollection < Dish::Plate
    coerce :resources, Asset

    # [todo] - metaprogram any proxy methods?
    #        - be sure to define method_missing AND respond_to_missing?

    # Acts as a proxy to resources.map
    #
    # @return [Array] The results of AssetCollection#resources#map
    def map(*args, &block)
      resources.map(*args, &block)
    end

    # Acts as a proxy to resources.first
    #
    # @return [Controls::Asset]
    def first
      resources.first
    end

    # Acts as a proxy to resources.last
    #
    # @return [Controls::Asset] the last asset in the
    #   {Controls::AssetCollection}
    def last
      resources.last
    end

    # Acts as a proxy to resources.[]
    #
    # @param [Fixnum] index the index of the asset to fetch
    # @return [Controls::Asset] the asset by index
    def [](index)
      resources[index]
    end

    # Returns a comma separated list of IP addresses
    #
    # @return [String]
    def to_s
      resources.sort_by(&:ipaddress).map(&:to_s).join("\n")
    end
  end
end
