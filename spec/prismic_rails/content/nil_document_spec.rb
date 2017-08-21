require "spec_helper"

RSpec.describe PrismicRails::NilDocument do
  specify { expect(subject.to_html).to eq('') }
  specify { expect(subject.to_text).to eq('') }
  specify { expect(subject.type).to eq(nil) }
end
