require 'prismic'

module PrismicRails
  module ViewHelpers

    def welcome text
      content_tag :p, text
    end

    def prismic_url
      url = PrismicRails.config.url
      content_tag :p, url
    end

    def prismic_tag(type, options = {}, &block)
      Rails.cache.fetch [PrismicRails.ref, options] do
        response = PrismicRails::QueryService.type(type, options)
        result = PrismicRails::ParserService.new(response).result
        capture(result, &block)
      end
    end

  end
end
