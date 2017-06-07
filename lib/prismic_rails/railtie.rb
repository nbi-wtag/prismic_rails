require 'prismic_rails/helpers/view_helpers'

# :nodoc:
module PrismicRails
  # Setup class for the custom initializer
  class Railtie < Rails::Railtie
    config.prismic_rails = ActiveSupport::OrderedOptions.new # enable namespaced configuration in Rails environments

    initializer "prismic_rails.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end

    initializer 'prismic_rails.configure' do |app|
      PrismicRails.configure do |config|
        config.url = app.config.prismic_rails[:url]
        config.token = app.config.prismic_rails[:token]
        config.client_id = app.config.prismic_rails[:client_id]
        config.client_secret = app.config.prismic_rails[:client_secret]
        config.languages = app.config.prismic_rails[:languages]
        config.caching = app.config.prismic_rails[:caching]
      end
    end
  end

end
