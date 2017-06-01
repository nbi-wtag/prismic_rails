require 'prismic-rails/view_helpers'

module PrismicRails
  class Railtie < Rails::Railtie
    config.prismic_rails = ActiveSupport::OrderedOptions.new # enable namespaced configuration in Rails environments

    initializer "prismic-rails.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end

    initializer 'prismic-rails.configure' do |app|
      PrismicRails.configure do |config|
        config.url = app.config.prismic_rails[:url]
        config.token = app.config.prismic_rails[:token]
        config.client_id = app.config.prismic_rails[:client_id]
        config.client_secret = app.config.prismic_rails[:client_secret]
      end
    end
  end

end
