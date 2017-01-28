[![Gem Version](https://badge.fury.io/rb/middleman-twitter-oembed.svg)](http://badge.fury.io/rb/middleman-twitter-oembed)
[![Build Status](https://travis-ci.org/atarukodaka/middleman-twitter-oembed.svg)](https://travis-ci.org/atarukodaka/middleman-twitter-oembed)
[![Coverage Status](https://coveralls.io/repos/atarukodaka/middleman-twitter-oembed/badge.svg)](https://coveralls.io/r/atarukodaka/middleman-twitter-oembed)
[![Code Climate](https://codeclimate.com/github/atarukodaka/middleman-twitter-oembed/badges/gpa.svg)](https://codeclimate.com/github/atarukodaka/middleman-twitter-oembed)


## Middleman::TwitterOembed

An extension to render and/or convert twitter stauts id into o-Embed status.
see https://dev.twitter.com/rest/reference/get/statuses/oembed for detail of twitter o-Embed.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'middleman-twitter-oembed'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install middleman-twitter-oembed

## Usage

in config.rb:

    activate :twitter_oembed

### convert before rendering

on default, twitter url(like 'http://twitter.com/foo/status/123456789') will be converted to twitter box before rendering.

You can change the regex to match:

```ruby
activate :twitter_oembed do |twitter|
  twitter.convert_regex = %r{\[\[twitter: *(\d+)\]\]}
end
```

If you don't want to convert, set false for enable_convert option:

```ruby
activate :twitter_oembed do |twitter|
  twitter.enable_convert = false
end
```

### helper

in *.erb:

```
<%= twitter_oembed('123456789') %>

or

<%= twitter_oembed_by_url('http://twitter.com/foo/status/123456789') %>
```

### caching

in default, the result of oEmbed will be cached.

```ruby
activate :twitter_oembed do |twitter|
  twitter.use_cache = true
  twitter.cache_dir = ".caches/twitter-oembed"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/atarukodaka/middleman-twitter-oembed/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
