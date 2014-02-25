require 'rspec/expectations'

RSpec::Matchers.define :match_format do |expected_format|
  match do |actual|
    resources = case actual
                when Array then actual.sample(3)
                else [actual]
                end
    resources.map!(&:as_hash)

    resources.each do |resource|
      expected_format.keys.each do |key|
        expect(expected_format[key].include?(resource[key].class)).to be_true
        expect(resource).to have_key(key)
      end
    end
  end
end
