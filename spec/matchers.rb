require 'rspec/expectations'

# Assessment Matchers
RSpec::Matchers.define :match_assessment_format do
  match do |resource|
    [
      resource.high_risk_asset_count,
      resource.id,
      resource.low_risk_asset_count,
      resource.medium_risk_asset_count,
      resource.timestamp.to_i, # Reverses the coercion
      resource.total_asset_count
    ].each do |attribute|
      expect(attribute.class).to eq(Fixnum)
    end

    assessing_is_boolean = [TrueClass, FalseClass].include?(resource.assessing.class)
    risk_score_is_float = [Float].include?(resource.overall_risk_score.class)
    expect(assessing_is_boolean).to be_true
    expect(risk_score_is_float).to be_true
  end
end
