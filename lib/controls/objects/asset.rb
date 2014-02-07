require 'controls/objects/security_control_finding'

module Controls
  class Asset < Dish::Plate
    coerce :discoveredAt, ->(value) { Time.at(value / 1000) if value }
    coerce :securityControlFindings, Controls::SecurityControlFinding

    def to_s
      %(#{host_name} (#{ipaddress}) - #{operating_system})
    end
  end

  class AssetCollection < Dish::Plate
    coerce :resources, Asset

    def map(*args, &block)
      resources.map(*args, &block)
    end

    def first
      resources.first
    end

    def last
      resources.last
    end

    def [](index)
      resources[index]
    end

    def to_s
      resources.sort_by(&:ipaddress).map(&:to_s).join("\n")
    end
  end
end
