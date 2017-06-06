module PrismicRails
  class NilDocument

    def initialize
      @document = ''
    end

    def to_html
      @document
    end

    def to_text
      @document
    end

    def type
      nil
    end

    def is_type? type
      false
    end

  end
end
