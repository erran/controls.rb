require_relative '../../spec_helper.rb'

describe '/api/security_controls' do
  before do
    login_to_environment
  end

  context 'GET /api/security_controls' do
    it 'returns a list of security controls' do
      security_controls = Controls.security_controls

      security_controls.each do |security_control|
        enabled_is_boolean = [TrueClass, FalseClass].include?(security_control.enabled.class)
        expect(enabled_is_boolean).to be_true
      end
    end
  end

  context 'GET /api/security_controls/desktops-with-antivirus-deployed' do
    it 'returns a single security control' do
      security_control = Controls.security_controls('desktops-with-antivirus-deployed')

      expect(security_control.name).to eq('desktops-with-antivirus-deployed')

      enabled_is_boolean = [TrueClass, FalseClass].include?(security_control.enabled.class)
      expect(enabled_is_boolean).to be_true
    end
  end
end
