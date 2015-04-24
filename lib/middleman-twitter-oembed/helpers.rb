module Middleman::TwitterOembed
  module Helpers
    def twitter_oembed(status_id)
      ext = extensions[:twitter_oembed]
      res = ext.interface.get_tweet(status_id)
      res['html']
    end
    alias_method :twitter_oembed_by_status_id, :twitter_oembed
    
    def twitter_oembed_by_url(url)
      regex = %r{https?://twitter.com/[a-zA-Z0-9_]+/status/(\d+)}
      url =~ regex
      status_id = $1
      logger.debug url
      logger.debug status_id
      twitter_oembed(status_id)
    end
  end ## module Helpers
end  
