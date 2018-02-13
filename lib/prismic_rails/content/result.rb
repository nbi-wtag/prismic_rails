# :nodoc:
module PrismicRails
  # The PrismicRails::Result object is a wrapper object around the
  # Prismic::Response.
  # The purpose of this wrapper object is to have an easy access on the included
  # documents or to query a specific fragment.
  class Result

    attr_accessor :documents

    # Creates the PrismicRails::Result object with the initial documents.
    #
    # ==== Attributes
    #  +response+ The response of the Prismic API query
    def initialize(response)
      if response
        @documents = response.results.map do |document|
          PrismicRails::Document.new(document)
        end
      else #Handles the case if the response is nil
        @documents = []
      end
    end

    # Find a specific fragment in the list of all document.
    #
    # ==== Examples
    #
    #   PrismicRails::Result.find_fragment('image')
    # This call walks through all the document and looks for a fragment with
    # the type 'image'.
    def find_fragment(type)
      @documents.each do |document|
        return document.find_fragment(type)
      end
    end

  end
end
