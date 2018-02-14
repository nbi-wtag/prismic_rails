require "spec_helper"

RSpec.describe PrismicRails::NilDocument do
  specify { expect(subject.as_html).to eq('') }
  specify { expect(subject.as_text).to eq('') }
  specify { expect(subject.type).to eq(nil) }
end
