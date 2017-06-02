require 'prismic'

require "prismic-rails/version"

if defined?(Rails)
  require 'prismic-rails/railtie'
  require 'generators/prismic_rails/install_generator'
end

module PrismicRails

  class Config
    attr_accessor :url, :token, :client_id, :client_secret
  end

  def self.config
    @@config ||= Config.new
  end

  def self.configure
    yield self.config
  end

  def self.api
    Prismic.api(self.config.url, self.config.token)
  end

end
