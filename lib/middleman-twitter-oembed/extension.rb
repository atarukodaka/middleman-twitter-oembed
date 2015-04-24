require 'middleman-twitter-oembed/helpers'
module Middleman::TwitterOembed
  class Interface
    def initialize(options)
    end
  end
end

module Middleman
  module TwitterOembed
    class Extension < Middleman::Extension
      include ERB::Util
      
      option :convert_regex, %r{https?://twitter.com/[a-zA-Z0-9_]+/status/(\d+)}
      option :use_cache, true
      option :cache_dir, ".caches/twitter_oembed"
      
      self.defined_helpers = [::Middleman::TwitterOembed::Helpers]

      def initialize(klass, options_hash={}, &block)
        super
        #klass.set :twitter_oembed_settings, options

        @result_cache = {}
        
        extension = self
        klass.before_render do |body|
          extension.convert(body)
        end
      end
      def convert(body)
        require 'open-uri'
        require 'json'

        #regex = %r{https?://twitter.com/[a-zA-Z0-9_]+/status/(\d+)}
        regex = options.convert_regex
        body.gsub(regex){
          res = get_tweet($1)
          res['html']
        }
      end
      def get_tweet(status_id)
        return @result_cache[status_id] if @result_cache.has_key?(status_id)
        return @result_cache[status_id] = load_cache(status_id) if options.use_cache && File.exist?(cache_filename(status_id))
        
        url = "https://api.twitter.com/1/statuses/oembed.json?id=#{h(status_id)}"
        begin
          res = JSON.parse(open(url).read)
          ## yet to rescue
        end

        @result_cache[status_id] = res
        save_cache(status_id, res) if options.use_cache

        return res
      end
      private
      def cache_filename(status_id)
        File.join(options.cache_dir, status_id)
      end
      def load_cache(asin)
        Marshal.load(File.read(cache_filename(asin)))
      end
      def save_cache(asin, hash)
        dir = File.dirname(cache_filename(asin))
        require 'fileutils'
        FileUtils.mkdir_p(dir) unless File.exists?(dir)
        File.open(cache_filename(asin), 'wb'){|f| f.write(Marshal.dump(hash))}
      end
    end ## class Extension
  end
end
