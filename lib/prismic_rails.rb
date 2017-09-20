require 'prismic'
require 'rails'
require "prismic_rails/version"
require 'prismic_rails/railtie'
require "prismic_rails/helpers/view_helpers.rb"
require "prismic_rails/services/query_service.rb"
require "prismic_rails/services/language_service.rb"
require "prismic_rails/content/result.rb"
require "prismic_rails/content/document.rb"
require "prismic_rails/content/fragment.rb"
require "prismic_rails/content/nil_document.rb"

# :nodoc:
module PrismicRails

  # A simple Config class that holds the config objects
  class Config
    attr_accessor :url,       # Prismic API URL
      :token,                 # Prismic API Token 
      :client_id,             # Client ID
      :client_secret,         # Client Secret
      :languages,             # Language maching hash
      :caching                # Changing enabled?
  end

  # Initalize the Config class
  def self.config
    @@config ||= Config.new
  end

  # Set the configs
  def self.configure
    yield self.config
  end

  # Returns the Prismic::API Object or nil if prismic.io is down
  def self.api
    begin
      @api = Prismic.api(self.config.url, self.config.token)
    rescue Prismic::API::PrismicWSConnectionError,
      Prismic::API::BadPrismicResponseError,
      Prismic::API::PrismicWSAuthError,
      SocketError,
      Net::OpenTimeout
        @api = nil
    end
  end

  # Get the master ref of prismic account. This is primarily used to establish a
  # caching mechanism.
  def self.ref
    if caching_enabled?
      get_cached_ref
    else
      get_ref
    end
  end

  # returns if the caching is enabled
  def self.caching_enabled?
    PrismicRails.config.caching
  end

  # Get the master ref out of the rails cache if prismic is not available
  def self.get_cached_ref
    if api.nil?
      @ref = Rails.cache.fetch('prismic_rails_ref')
    else
      master_ref = get_ref
      Rails.cache.write('prismic_rails_ref', master_ref)
      @ref = master_ref
    end
  end

  # Get the master ref from the Prismic::API object
  def self.get_ref
    api.master_ref.ref
  end

  def self.find(document_type, fragment_id, options = {})
    if options[:lang]
      PrismicRails::QueryService.type(document_type, lang: options[:lang]).find_fragment(fragment_id)
    else
      PrismicRails::QueryService.type(document_type).find_fragment(fragment_id)
    end
  end

end
