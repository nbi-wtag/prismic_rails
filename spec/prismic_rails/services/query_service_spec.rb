require "spec_helper"

RSpec.describe PrismicRails::QueryService do
  describe '#by_type', :vcr do
    context 'without language set' do
      it 'should return a prismic response' do
        expect(subject.by_type('text')).to be_a(PrismicRails::Result)
      end
    end

    context 'with language set' do
      let(:options) { { lang: "en" } }
      it 'should return a prismic response' do
        expect(subject.by_type('text', options)).to be_a(PrismicRails::Result)
      end
    end

    context 'with more query options' do
      let(:bar_options) do
        { q: { 'my.text.select': 'Bar' } }
      end

      it 'should return a prismic response' do
        expect(subject.by_type('text', bar_options)).to be_a(PrismicRails::Result)
      end
    end
  end

  describe '#query' do
    let(:foo_options) do
      {
        q: {
          'my.text.select': 'Foo',
          'document.type': 'text'
        }
      }
    end

    let(:bar_options) do
      {
        q: {
          'my.text.select': 'Bar',
          'document.type': 'text'
        }
      }
    end

    it 'should return a prismic response' do
      expect(subject.query(foo_options)).to be_a(PrismicRails::Result)
    end

    context 'find_fragment' do
      it 'should return the right title for a title query: `Lorem Ipsum`' do
        expect(subject.query(foo_options).find_fragment('title').as_text).to be_eql("Lorem Ipsum")
      end

      it 'should not return a wrong title' do
        expect(subject.query(foo_options).find_fragment('title').as_text).not_to be_eql("Lorem")
      end
    end

    context 'by languages' do
      let(:lang_de) { { lang: 'de' } }
      let(:lang_en) { { lang: 'en' } }

      context 'de' do
        let(:query_options) {
          bar_options.merge(lang_de)
        }

        it 'should return the content in german' do
          expect(subject.query(query_options).find_fragment('rich_text').as_text).to be_eql("Hallo du")
        end
      end

      context 'en' do
        let(:query_options) {
          bar_options.merge(lang_en)
        }

        it 'should return the content in english' do
          expect(subject.query(query_options).find_fragment('rich_text').as_text).to be_eql("Hello you")
        end
      end
    end
  end


end
