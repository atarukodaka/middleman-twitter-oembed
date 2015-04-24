module Middleman
  module TwitterOembed
    module Helpers
      def twitter_oembed(url)
      end
    end ## module Helpers

    class Extension < Middleman::Extension    
      self.defined_helpers = [::Middleman::TwitterOembed::Helpers]

      def initialize(klass, options_hash={}, &block)
        super
        #klass.set :aks_settings, options

        extension = self
        klass.before_render do |body|
          extension.convert(body)
        end
      end
      def convert(body)
        require 'open-uri'
        require 'json'
        
        regex = %r{https?://twitter.com/[a-zA-Z0-9_]+/(\d+)}
        body.gsub(regex){
          binding.pry
          status_id = $1
          url = "https://api.twitter.com/1/statuses/oembed.json?id=#{status_id}"
          res = JSON.parse(open(url).read)
          res['html']
        }
      end
      
    end ## class Extension
  end
end
