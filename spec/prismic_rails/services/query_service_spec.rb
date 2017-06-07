require "spec_helper"

RSpec.describe PrismicRails::QueryService do

  # it 'should have constante document type' do
  #   expect(subject:DOCUMENT_TYPE).to be_eql('document.type')
  # end
  #
  describe '#type', :vcr do
    context 'without language set' do
      it 'should return a prismic response' do
        expect(subject.type('text')).to be_a(Prismic::Response)
      end

      it '
    end
  end


end
