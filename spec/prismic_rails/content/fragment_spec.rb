require "spec_helper"

RSpec.describe PrismicRails::Fragment do

  let(:subject) do
    VCR.use_cassette 'PrismicRails_QueryService/_type/without_language_set/should_return_a_prismic_response' do
      response = PrismicRails::QueryService.by_type('text')
      document = response.documents.first
      document.find_fragment('title')
    end
  end

  specify { expect(subject).to be_a(PrismicRails::Fragment) }
  specify { expect(subject).to respond_to(:as_html) }
  specify { expect(subject).to respond_to(:as_text) }
end
