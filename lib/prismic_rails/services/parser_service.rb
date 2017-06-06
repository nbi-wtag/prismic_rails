module PrismicRails
  class ParserService
    attr_accessor :result

    def initialize(response)
      @result = PrismicRails::Result.new(response.results)
    end


  end
end
