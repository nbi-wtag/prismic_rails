require "spec_helper"

RSpec.describe PrismicRails::Fragment do

  let(:subject) do
    VCR.use_cassette 'PrismicRails_QueryService/_type/without_language_set/should_return_a_prismic_response' do
      response = PrismicRails::QueryService.type('text')
      document = response.results.first
      described_class.new(document.fragments['image'])
    end
  end

  specify { expect(subject).to be_a(PrismicRails::Fragment) }
  specify { expect(subject).to respond_to(:to_html) }
  specify { expect(subject).to respond_to(:to_text) }
end
