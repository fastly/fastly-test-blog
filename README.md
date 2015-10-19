# Fastly Fake Blog

This is a blog style application with fake content that can be cached and purged using Fastly.

### Installation

You will set up a new service in your Fastly account, and configure it in order to familiarize yourself with your account. If you do not have a Fastly account, you will need to create one: https://www.fastly.com/signup

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/fastly/fastly-fake-blog)

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

**Setting up your Fastly Service**

Within your Fastly account, create a new Service. For this you'll need:

* Name -  type the name of the first service you'd like to create
* Origin Server Name - type the IP address (or hostname) and port number (usually 80) for your website's server. e.g., `https:\\<HEROKU_URL>`
* Domain Name - type the domain name of your website. e.g., `<HEROKU_URL>`

**Finding the Fastly Headers**

If your request is being served by Fastly, you will see the following three headers. You will also use these header to determine if your content is cached or not.

* X-Served-By
* X-Cache
* X-Cache-Hits

You can use `curl -svo /dev/null <FASTLY_TEST_URL>` to see the Fastly Headers. You can also find the request headers for any request in your browser's web inspector or developer tools.

**Changing the TTL of content**

You can change the TTL, or how long the content is cached, by creating a new Cache Setting using the Fastly Configuration Control Panel.

For example, if you wanted to change the TTL for all `/articles` pages, you would create the following Cache Setting.

* Name - Article pages 2 mins
* TTL - 120 (seconds)
* Stale TTL - 0 (seconds)
* Action - Deliver

Then create a condition to match the content.

* Name - Article pages
* Apply if - `req.url ~ "^/articles/"`
* Priority - 10 (default)

Then activate the version with these changes. If you have previously requested content that matches your new setting, you will need to purge it. You can purge by URL, Surrogate Key, or Purge All.

**Passing content**

If you do not want specific content to cache, you can create a Cache Setting to Pass on the content instead. You will use the same process for changing the TTL with a few adjustments.

* Name - Pass About page
* TTL - 0 (seconds)
* Stale TTL - 0 (seconds)
* Action - Pass

Then create a condition to match the content.

* Name - About page
* Apply if - `req.url ~ "^/about"`
* Priority - 5

### License

MIT license, see LICENSE.md
