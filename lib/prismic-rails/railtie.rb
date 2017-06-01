require 'prismic-rails/view_helpers'

module PrismicRails
  class Railtie < Rails::Railtie
    config.prismic = ActiveSupport::OrderedOptions.new # enable namespaced configuration in Rails environments

    initializer "welcome.helper" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
