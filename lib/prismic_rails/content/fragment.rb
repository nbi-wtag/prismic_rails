# :nodoc:
module PrismicRails
  # The PrismicRails::Fragment is a wrapper class around Prismic::Fragment
  class Fragment

    # Create a new instance of PrismicRails::Fragment
    #   +fragment+ A Prismic::Fragment
    def initialize(fragment)
      @fragment = fragment
    end

    # Returns the document as safe html
    def as_html(serializer = nil)
      @fragment.as_html(serializer)
    end

    # Returns only the text of a document
    def as_text
      @fragment.as_text
    end

  end
end
