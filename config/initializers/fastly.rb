FastlyRails.configure do |c|
  c.api_key = ENV['FASTLY_API_KEY'] # Fastly api key, required
  c.max_age = 86400 # time in seconds, optional, currently set to 1 day
  c.service_id = ENV['FASTLY_SERVICE_ID'] # The Fastly service you will be using, required
  c.purging_enabled = false unless ENV['ENABLE_PURGE']
end
