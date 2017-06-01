module PrismicRails
  module ViewHelpers

    def welcome text
      content_tag :p, text
    end

    def prismic_url
      url = PrismicRails.config.url
      content_tag :p, url
    end

    def prismic_text (ref, options = {})
      response = PrismicRails.api.query(
        [ Predicates.at("document.type", "simple_text") ]
      );
      response.each do |doc|
        content_tag :article, doc.as_html(Prismic::LinkResolver.new(nil))
      end
    end

    def prismic_content ref
      documents = PrismicRails.api.all({
        "page" => params[:page] ? params[:page] : "1",
        "page_size" => params[:page_size] ? params[:page_size] : "20",
        "ref" => ref
      })
      documents.each do |doc|
        content_tag :article, doc.as_html(Prismic::LinkResolver.new(nil))
      end
    end

  end
end
