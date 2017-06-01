require 'prismic-rails/view_helpers'

module PrismicRails
  class Railtie < Rails::Railtie
    config.prismic = ActiveSupport::OrderedOptions.new # enable namespaced configuration in Rails environments

    initializer "prismic.configure" do |app|
      PrismicRails.configure do |config|
        config.key = app.config.prismic_rails[:key] || self.app_name
      end
    end

    initializer "prismic.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end

    private

    def self.app_name
      ::Rails.application.class.to_s.split("::").first
    end
  end
end
