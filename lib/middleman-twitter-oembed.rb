require "middleman-twitter-oembed/version"

::Middleman::Extensions.register(:twitter_oembed) do
  require 'middleman-twitter-oembed/extension'
  ::Middleman::TwitterOembed::Extension
end

