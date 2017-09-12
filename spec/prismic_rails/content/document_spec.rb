require "spec_helper"

RSpec.describe PrismicRails::Document do

  let(:subject) do
    VCR.use_cassette 'PrismicRails_QueryService/_type/without_language_set/should_return_a_prismic_response' do
      response = PrismicRails::QueryService.type('text')
      described_class.new(response.results.first)
    end
  end

  specify { expect(subject).to be_a(PrismicRails::Document) }
  specify { expect(subject).to respond_to(:to_html) }
  specify { expect(subject.to_text).to be_a(String) }
  specify { expect(subject.find_fragment('text')).to be_a(PrismicRails::Fragment) }

  describe '#is_type?' do
    context 'type is matched' do
      it 'returns ture' do
        expect(subject.is_type?('text')).to eq(true)
      end
    end

    context 'type did not matched' do
      it 'returns false' do
        expect(subject.is_type?('image')).to eq(false)
      end
    end
  end
end
