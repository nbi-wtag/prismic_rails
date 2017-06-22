# :nodoc:
module PrismicRails
  # The PrismicRails::QueryService is a small helper to query the Prismic API with
  # support for query types.
  # It also helps to create the right query for your i18n support.
  module QueryService
    # :nodoc:
    class << self

      # Constant that holds the query string to query the document type
      DOCUMENT_TYPE = 'document.type'.freeze

      # Query the Prismic API with a type
      # ==== Examples
      #   PrismicRails::QueryService.type('blog-post')
      #
      # This returns a Prismic::Response with all the (published) documents of
      # the type 'blog-post'
      #
      #   PrismicRails::QueryService.type('blog-post', {lang: 'en'}
      #
      # This returns a Prismic::Response with all the (published) documents of
      # the type 'blog-post' in english.
      #
      def type(type, options = {})
        match_language options if options[:lang]
        query(predicates(type), options)
      end

      private

      # Do the actual query against the Prismic API
      def query(predicates, options)
        api.query(predicates,
                 options)
      end

      # Creates the Prismic::Predicates for a given type
      def predicates type
        Prismic::Predicates.at(DOCUMENT_TYPE, type)
      end

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
