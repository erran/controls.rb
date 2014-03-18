require 'rspec/expectations'

# Assessment Matchers
RSpec::Matchers.define :match_assessment_format do
  match do |resource|
    # Reverses the coercion
    [
      resource.high_risk_asset_count,
      resource.id,
      resource.low_risk_asset_count,
      resource.medium_risk_asset_count,
      resource.timestamp.to_i,
      resource.total_asset_count
    ].each do |attribute|
      expect(attribute.class).to eq(Fixnum)
    end

    expect([TrueClass, FalseClass].include?(resource.assessing.class)).to be_true
    expect([Float].include?(resource.overall_risk_score.class)).to be_true
  end
end
