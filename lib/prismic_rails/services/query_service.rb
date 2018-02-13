# :nodoc:
module PrismicRails
  # The PrismicRails::QueryService is a small helper to query the Prismic API with
  # support for query types.
  # It also helps to create the right query for your i18n support.
  module QueryService
    # :nodoc:
    class << self

      # Query the Prismic API with a type
      # ==== Examples
      #   PrismicRails::QueryService.type('blog-post')
      #
      # This returns a Prismic::Response with all the (published) documents of
      # the type 'blog-post'
      #
      #   PrismicRails::QueryService.type('blog-post', {lang: 'en'}
      #
      # This gets all the (published) documents of
      # the type 'blog-post' in english as a Prismic::Response and wraps it around with a PrismicRails::Result
      #
      #

      def by_type(type, options = {})
        options[:q].merge({'document.type': type})
        query(options)
      end

      def query(options = {})
        match_language(options) if options[:lang]
        predicates = []
        if q = options.delete(:q)
          q.each do |key, value|
            predicates << Prismic::Predicates.at(key, value)
          end
        end
        puts predicates.inspect
        response = api.query(predicates, options)
        PrismicRails::Result.new(response)
      end

      private

      # Returns the Prismic::Api object
      def api
        PrismicRails.api
      end

      # Helper method to match the i18n locale to the prismic locale
      def match_language options
        options[:lang] = PrismicRails::LanguageService.call(options[:lang])
      end

    end
  end
end
