require 'prismic'

# :nodoc:
module PrismicRails
  # :nodoc:
  module ViewHelpers

    # Query prismic for a specific type
    #
    # ==== Examples:
    # Query the prismic type 'blog-post' and render each document as html
    #   <% prismic_type 'blog-post' do |result| %>
    #     <%- result.documents.each do |document| %>
    #       <%= document.to_html %>
    #     <% end %>
    #   <% end %>
    #
    # Query the prismic type 'blog-post' in english
    #   <% prismic_type 'blog-post', lang: 'en' do |result| %>
    #     <%- result.documents.each do |document| %>
    #       <%= document.to_html %>
    #     <% end %>
    #   <% end %>
    #
    # Query only the title of the type 'blog-post
    #
    #   <% prismic_type 'tea' do |result| %>
    #     <%= result.find_fragment('title').to_html %>
    #   <% end %>
    #
    #
    # Supports Rails caching if the caching is enabled
    def prismic_type(type, options = {}, &block)

      query = Proc.new do
        response = PrismicRails::QueryService.type(type, options)
        result = PrismicRails::Result.new(response)
        capture(result, &block)
      end

      if PrismicRails.caching_enabled?
        Rails.cache.fetch [PrismicRails.ref, options] do
          query.call
        end
      else
        query.call
      end
    end
  end
end
