module PrismicRails
  class Document

    def initialize(document)
      @document = document || PrismicRails::NilDocument.new
    end

    def to_html
      @document.as_html(nil).html_safe
    end

    def to_text
      @document.as_text
    end

    def find_fragment(type)
      fragment = @document.fragments[type]
      return PrismicRails::Fragment.new(fragment) || NilDocument.new
    end

    def is_type? type
      type == @document.type
    end
  end
end
