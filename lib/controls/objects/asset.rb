module Controls
  # A representation of the Asset resource
  class Asset < Dish::Plate
    coerce :discoveredAt, ->(value) { Time.at(value / 1000) if value }

    # Retreives the security control and configuration findings for this
    # {Asset} instance by UUID
    #
    # @return [Array<SecurityControlFindings>]
    def findings
      @findings ||= Controls.client.findings_by_asset_uuid(uuid)
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
end
