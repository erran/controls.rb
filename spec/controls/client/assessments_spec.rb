require 'controls'

describe Controls::Client::Assessments do
  before do
    # Allow self-signed certs in continuous integration
    Controls.verify_ssl = false
    Controls.login(ENV['CONTROLS_USERNAME'], ENV['CONTROLS_PASSWORD'])
  end

  it 'returns a list of assessments' do
    expect(Controls.assessments).to match_format(assessment_format)
  end
end
