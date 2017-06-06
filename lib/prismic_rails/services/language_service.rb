module PrismicRails
  class LanguageService

    attr_accessor :locale

    def self.call(locale)
      new(locale).match()
    end

    def initialize(locale)
      @locale = locale
    end

    def match
      return language_hash[@locale.to_sym]
    end

    def yaml_file
      file = File.read(File.expand_path(FILE_PATH, __FILE__))
      YAML.load(file)
    end

    def language_hash
      HashWithIndifferentAccess.new(PrismicRails.config.languages)
    end

  end
end

