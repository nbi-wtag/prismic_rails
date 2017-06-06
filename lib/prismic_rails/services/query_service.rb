module PrismicRails
  module QueryService
    class << self

      DOCUMENT_TYPE = 'document.type'.freeze

      def type(type, options = {})
        match_language options if options[:lang]
        query(predicates(type), options)
      end

      private

      def query(predicates, options)
        api.query(predicates,
                 options)
      end

      def predicates type
        Prismic::Predicates.at(DOCUMENT_TYPE, type)
      end

      def language
      end

      def api
        PrismicRails.api
      end

      def match_language options
        options[:lang] = PrismicRails::LanguageService.call(options[:lang])
      end

    end
  end
end
