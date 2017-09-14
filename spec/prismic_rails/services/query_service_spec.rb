require "spec_helper"

RSpec.describe PrismicRails::QueryService do
  describe '#type', :vcr do
    context 'without language set' do
      it 'should return a prismic response' do
        expect(subject.type('text')).to be_a(PrismicRails::Result)
      end
    end
  end
end
