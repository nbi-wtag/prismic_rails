module PrismicRails
  module ViewHelpers

    def welcome text
      content_tag :p, text
    end

    def prismic_url
      url = PrismicRails.config.url
      content_tag :p, url
    end

  end
end
