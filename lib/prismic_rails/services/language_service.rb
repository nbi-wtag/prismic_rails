# :nodoc:
module PrismicRails
  # The PrismicRails::LanguageService tries to match your i18n locale to the
  # Prismic locale.
  #
  # E.g. If your rails app support the locales :en, :de and :fr and you want to
  # support this locales with your prismic content you have to match this
  # locals.
  # In Prismic you have the posibility to define a finer graded set of locals,
  # e.g. 'en-gb', 'en-us', 'de-de', 'de-ch' and so on.
  # Unfortunatly Prismic does not support a wildecard query on the locals, so we
  # solve this problem by setting up a matching logic.
  #
  # You can define the matching logic in your PrismicRails configureation.
  class LanguageService

    # Stores the given locale
    attr_accessor :locale

    # Call the PrismicRails::LanguageService with a i18n locale form rails. The
    # PrismicRails::LanguageService tries to match it into a prismic local.
    def self.call(locale)
      new(locale).match()
    end

    # Creates a instance of the class PrismicRails::LanguageService
    def initialize(locale)
      @locale = locale
    end

    # Tries to match the given locale to a prismic locale
    def match
      return language_hash[@locale.to_sym] || '*'
    end

    # Creates the language hash out of the PrismicRails::Config
    def language_hash
      HashWithIndifferentAccess.new(PrismicRails.config.languages)
    end

  end
end

