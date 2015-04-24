module Middleman
  module TwitterOembed
    module Helpers
      def twitter_oembed(status_id)
        ext = extensions[:twitter_oembed]
        res = ext.get_tweet(status_id)
        res['html']
      end
      alias_method :twitter_oembed_by_status_id, :twitter_oembed
      
=begin
      def twitter_oembed_by_url(url)
        raise
        regex = %r{https?://twitter.com/[a-zA-Z0-9_]+/status/(\d+)}
        url =~ regex
        status_id = $1
        logger.debug url
        logger.debug status_id
        twitter_oembed(status_id)
      end
=end
    end ## module Helpers
    
    class Extension < Middleman::Extension
      include ERB::Util
      
      self.defined_helpers = [::Middleman::TwitterOembed::Helpers]

      def initialize(klass, options_hash={}, &block)
        super
        #klass.set :twitter_oembed_settings, options

        extension = self
        klass.before_render do |body|
          extension.convert(body)
        end
      end
      def convert(body)
        require 'open-uri'
        require 'json'

        regex = %r{https?://twitter.com/[a-zA-Z0-9_]+/status/(\d+)}
        body.gsub(regex){
          res = get_tweet($1)
          res['html']
        }
      end
      def get_tweet(status_id)
        url = "https://api.twitter.com/1/statuses/oembed.json?id=#{h(status_id)}"
        JSON.parse(open(url).read)
      end
    end ## class Extension
  end
end
