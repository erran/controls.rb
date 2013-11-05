require 'helper'

# TODO: Add more tests
describe Controls do
  before { Controls.reset! }
  after  { Controls.reset! }

  it 'is configured with default values from the environment' do
    Controls::Configurable.keys.each do |key|
      actual = Controls.instance_variable_get(:"@#{key}")
      expected = Controls::Default.send(key)

      expect(actual).to eq(expected)
    end
  end

  describe 'Controls.client' do
    it 'is an instance of Controls::Client' do
      expect(Controls.client).to be_kind_of Controls::Client
    end
  end
end
