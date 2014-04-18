require_relative '../../spec_helper'

describe '/api/assessments' do
  before do
    login_to_environment
  end

  context 'GET /api/assessments' do
    it 'returns a list of assessments' do
      assessments = Controls.assessments

      assessments.each do |assessment|
        expect(assessment).to be_kind_of(Controls::Assessment)
        expect(assessment).to match_assessment_format
      end
    end
  end

  context 'GET /api/assessments/1' do
    it 'returns a single assessment' do
      assessment = Controls.assessments(1)

      expect(assessment).to be_kind_of(Controls::Assessment)
      expect(assessment).to match_assessment_format
      expect(assessment.id).to eq(1)
      expect(assessment.assessing?).to be_false
      expect(assessment.overall_risk_score).to be_within(5.0).of(5.0)
    end
  end
end
