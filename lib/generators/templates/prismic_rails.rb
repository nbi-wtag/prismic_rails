PrismicRails.configure do |config|
  config.url = ENV.fetch("PRISMIC_API_URL", "")
  config.token = ENV.fetch("PRISMIC_ACCESS_TOKEN", nil)
  config.languages do |l|
    l.en = 'en-gb'
    l.de = 'de-ch'
    l.fr = 'fr-ch'
    l.it = 'it-ch'
  end
end
