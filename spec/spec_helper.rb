require 'controls'
require_relative './matchers.rb'

module SpecHelpers
  def assessment_format
    {
      'assessing' => [TrueClass, FalseClass],
      'id' => [Fixnum],
      'overallRiskScore' => [Float],
      'timestamp' => [Fixnum],
      'highRiskAssetCount' => [Fixnum],
      'lowRiskAssetCount' => [Fixnum],
      'mediumRiskAssetCount' => [Fixnum],
      'totalAssetCount' => [Fixnum],
    }
  end
end

RSpec.configure do |rspec|
 rspec.include SpecHelpers
end
