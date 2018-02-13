# :nodoc:
module PrismicRails
  # The PrismicRails::QueryService is a small helper to query the Prismic API with
  # support for query types.
  # It also helps to create the right query for your i18n support.
  module QueryService
    # :nodoc:
    class << self

      # Constant that holds the query string to query the document type
      KEY_MAPPING = {
        uid: 'document.uid'.freeze,
        type: 'document.type'.freeze,
      }.freeze

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
      def type(type, options = {})
        match_language options if options[:lang]

        predicates = []
        predicates << build_predicate(:type, type)
        predicates << build_predicate(:uid, options.delete(:uid)) if options[:uid]

        response = query(predicates, options)
        PrismicRails::Result.new(response)
      end

      private

      # Do the actual query against the Prismic API
      def query(predicates, options)
        api.query(predicates,
                 options)
      end

      # Creates the Prismic::Predicates for a given type
      def build_predicate(key, value)
        query_key = KEY_MAPPING[key]
        raise "Unknown key #{key}" unless query_key
        Prismic::Predicates.at(query_key, value)
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
