require "spec_helper"

RSpec.describe PrismicRails::Document do

  let(:subject) do
    VCR.use_cassette 'PrismicRails_QueryService/_type/without_language_set/should_return_a_prismic_response' do
      response = PrismicRails::QueryService.by_type('text')
      response.documents.first
    end
  end

  specify { expect(subject).to be_a(PrismicRails::Document) }
  specify { expect(subject).to respond_to(:as_html) }
  specify { expect(subject.as_text).to be_a(String) }

  describe '#find_fragment' do
    context 'fragment exists' do
      it 'should return a PrismicRails::Fragment' do
        expect(subject.find_fragment('rich_text')).to(
          be_a(PrismicRails::Fragment))
      end
    end
    context 'fragment does not exists' do
      it 'should return a PrismicRails::NilDocument' do
        expect(subject.find_fragment('foo_bar_text_1234')).to(
          be_a(PrismicRails::NilDocument))
      end
    end
  end

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

  specify { expect(subject.document).to be_a(Prismic::Document) }

end
