require 'controls/objects/security_control_finding'

module Controls
  # A representation of the Asset resource
  class Asset < Dish::Plate
    coerce :discoveredAt, ->(value) { Time.at(value / 1000) if value }

    def findings
      Controls.client.findings_by_asset_uuid(uuid)
    end

    # Returns the hostname, IP, and OS of the asset
    #
    # @example
    #   "jdoe.local (192.168.1.23) - Windows 7 Professional Edition"
    #
    # @return [String]
    def to_s
      %(#{host_name} (#{ipaddress}) - #{operating_system})
    end
  end

  # A collection of Asset resources
  class AssetCollection < Dish::Plate
    coerce :resources, Asset

    # [todo] - metaprogram any proxy methods?
    #        - be sure to define method_missing AND respond_to_missing?

    # Acts as a proxy to resources.map
    #
    # @yield [resource] gives three resources
    def map(&block)
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
