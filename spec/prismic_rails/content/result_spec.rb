require "spec_helper"

RSpec.describe PrismicRails::Result do

  let(:subject) do
    VCR.use_cassette 'PrismicRails_QueryService/_type/without_language_set/should_return_a_prismic_response' do
      response = PrismicRails::QueryService.type('text')
      described_class.new(response)
    end
  end

  specify { expect(subject).to be_a(PrismicRails::Result) }
  specify { expect(subject.find_fragment('text')).to be_a(PrismicRails::Fragment) }
end
