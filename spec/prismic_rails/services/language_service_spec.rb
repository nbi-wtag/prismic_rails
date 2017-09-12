require 'spec_helper'

RSpec.describe PrismicRails::LanguageService do
  subject { described_class.new('en') }
  before do
    allow_any_instance_of(described_class).to receive(:language_hash).and_return({ en: 'en-us' })
  end

  describe '.call' do
    it 'calls #match' do
      expect_any_instance_of(described_class).to receive(:match).and_return('en-us')
      described_class.call('en')
    end
  end

  describe '#call' do
    it 'set locale to @locale' do
      expect(subject.locale).to eq('en')
    end
  end

  describe '#match' do
    it 'returns the matched locale' do
      expect(subject.match).to eq('en-us')
    end
  end

  describe '#language_hash' do
    it 'returns language_hash' do
      expect(subject.language_hash).to eq({ en: 'en-us' })
    end
  end
end
