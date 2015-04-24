module Middleman::TwitterOembed
  class Interface
    include ERB::Util
    
    def initialize(options = {})
      @use_cache = options[:use_cache] || true
      @cache_dir = options[:cache_dir] || "./caches/twitter_oembed"
      @omit_script = options[:omit_script] || false
      
      @result_cache = {}
    end
    def get_tweet(status_id)
      return @result_cache[status_id] if @result_cache.has_key?(status_id)
      return @result_cache[status_id] = load_cache(status_id) if @use_cache && File.exist?(cache_filename(status_id))
      
      url = "https://api.twitter.com/1/statuses/oembed.json?id=#{h(status_id)}"
      url += "&omit_script=true" if @omit_script
      begin
        require 'open-uri'
        require 'json'

        res = JSON.parse(open(url).read)
        ## yet to rescue
      end

      @result_cache[status_id] = res
      save_cache(status_id, res) if @use_cache

      return res
    end
    private
    def cache_filename(status_id)
      File.join(@cache_dir, status_id)
    end
    def load_cache(status_id)
      Marshal.load(File.read(cache_filename(status_id)))
    end
    def save_cache(status_id, res)
      dir = File.dirname(cache_filename(status_id))

      require 'fileutils'
      FileUtils.mkdir_p(dir) unless File.exists?(dir)
      File.open(cache_filename(status_id), 'wb'){|f| f.write(Marshal.dump(res))}
    end
  end
end

