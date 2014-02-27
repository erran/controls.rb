require 'rspec/expectations'

# Assessment Matchers
RSpec::Matchers.define :match_assessment_format do
  match do |resource|
    # Reverses the coercion
    resource.timestamp = resource.timestamp.to_i
    [
      resource.high_risk_asset_count,
      resource.id,
      resource.low_risk_asset_count,
      resource.medium_risk_asset_count,
      resource.timestamp,
      resource.total_asset_count
    ].each do |attribute|
      expect(attribute.class).to eq(Fixnum)
    end

    expect(resource.assessing.class).to include([TrueClass, FalseClass])
    expect(resource.overall_risk_score.class).to  include([Float])
  end
end

#RSpec::Matchers.define :match_event_format do
#  [Fixnum].include? resource.createdAt
#  [Hash].include? resource.payload
#  [String].include? resource.type
#  [String].include? resource.user
#end
#
#RSpec::Matchers.define :match_site_change_event_payload_format do
#  [TrueClass,FalseClass].include? resource.impactsGrade.class
#  [String].include? resource.notes.class
#  [String].include? resource.productVersion.class
#end
#
#RSpec::Matchers.define :match_security_control_change_event_payload_format do
#  [String,NilClass].include?resource.reason
#  [String]}]].include?resource.changes:[Array,[Hash,{securityControlName:[String],action
#end
#
#RSpec::Matchers.define :match__change_event_payload_format do
#  [String,NilClass].include?resource.reason
#  [Fixnum]}]].include?resource.enabledSites:[Array,[Hash,{name:[String],id
#  [TrueClass.include?resource.importAllFalseClass]
#end
