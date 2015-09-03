FastlyRails.configure do |c|
  c.api_key = ENV['FASTLY_API_KEY']
  # c.max_age = 86400 # 1 day
  c.service_id = ENV['FASTLY_SERVICE_ID']
  c.purging_enabled = false unless ENV['ENABLE_PURGE']
end
