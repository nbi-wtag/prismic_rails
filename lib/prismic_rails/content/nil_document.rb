# :nodoc:
module PrismicRails
  # The PrismicRails::NilDocument represents a empty document but you can call
  # any methods on it without getting an exception
  class NilDocument

    # Create a new instance of a PrismicRails::NilDocument
    def initialize
      @document = ''
    end

    # Returns the document as safe html, in this case simply an empty string
    def to_html
      @document
    end

    # Returns the document as text, in this case simply an empty string
    def to_text
      @document
    end

    # Returns the type nil of the NilDocument
    def type
      nil
    end

    # Returns nil
    def is_type? type
      false
    end

  end
end
