PrismicRails.configure do |config|
  config.url = ENV.fetch("PRISMIC_API_URL", "")
  config.token = ENV.fetch("PRISMIC_ACCESS_TOKEN", nil)
end
