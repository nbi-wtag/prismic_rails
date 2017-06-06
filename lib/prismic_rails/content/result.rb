module PrismicRails
  class Result

    attr_accessor :documents

    def initialize(prismic_documents)
      @documents = prismic_documents.map do |document|
        PrismicRails::Document.new(document)
      end
    end

    def find_fragment(type)
      @documents.each do |document|
        return document.find_fragment(type)
      end
    end

  end
end
