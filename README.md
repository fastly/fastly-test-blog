# Fastly Fake Blog

This is a blog style application with fake content that can be cached and purged using Fastly.

### Installation

You will set up a new service in your Fastly account, and configure it in order to familiarize yourself with your account. If you do not have a Fastly account, you will need to create one: https://www.fastly.com/signup

You will want to follow Heroku's [guide to deploying a Rails application](https://devcenter.heroku.com/articles/getting-started-with-rails4).

### Configuration

The initializer, `fastly.rb`, has the configurations for Fastly.

```
c.api_key = ENV['FASTLY_API_KEY'] # Fastly api key, required
c.max_age = 86400 # time in seconds, optional, currently set to 1 day
c.service_id = ENV['FASTLY_SERVICE_ID'] # The Fastly service you will be using, required
c.purging_enabled = false unless ENV['ENABLE_PURGE']
```

Please refer to our [documentation](https://docs.fastly.com/guides/account-management-and-security/finding-and-managing-your-account-info) to find your Fastly API Key and Fastly Service ID.

You can override `c.purging_enabled` with ENABLE_PURGE environment variable: `export ENABLE PURGE=1`

As is, `ENABLE_PURGE=1 bundle exec rake test` will fail unless the API Key and Service ID are set. Whereas, `bundle exec rake test` will pass, because purging is disabled.

### Using this application with your Fastly account

add condensed modules

### License

MIT license, see LICENSE.md
