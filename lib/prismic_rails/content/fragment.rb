module PrismicRails
  class Fragment

    def initialize(fragment)
      @fragment = fragment
    end

    def to_html
      @fragment.as_html(nil).html_safe
    end

    def to_text
      @fragment.as_text
    end

  end
end
