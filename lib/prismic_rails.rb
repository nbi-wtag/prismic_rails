require 'prismic'
require 'rails'
require "prismic_rails/version"
require 'prismic_rails/railtie'
require "prismic_rails/helpers/view_helpers.rb"
require "prismic_rails/services/query_service.rb"
require "prismic_rails/services/parser_service.rb"
require "prismic_rails/services/language_service.rb"
require "prismic_rails/content/result.rb"
require "prismic_rails/content/document.rb"
require "prismic_rails/content/fragment.rb"
require "prismic_rails/content/nil_document.rb"

module PrismicRails

  class Config
    attr_accessor :url,
      :token,
      :client_id,
      :client_secret,
      :languages,
      :caching
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield self.config
  end

  def self.api
    begin
      @api = Prismic.api(self.config.url, self.config.token)
    rescue Prismic::API::PrismicWSConnectionError,
      Prismic::API::BadPrismicResponseError,
      Prismic::API::PrismicWSAuthError,
      SocketError,
      Net::OpenTimeout => e
        @api = nil
    end
  end

  def self.ref
    if caching_enabled?
      get_cached_ref
    else
      get_ref
    end
  end

  def self.get_cached_ref
    if @api.nil?
      @ref = Rails.cache.fetch('prismic_rails_ref')
    else
      master_ref = get_ref
      Rails.cache.write('prismic_rails_ref', master_ref)
      @ref = master_ref
    end
  end

  def self.get_ref
    @api.master_ref.ref
  end

  def self.caching_enabled?
    PrismicRails.config.caching
  end

end
