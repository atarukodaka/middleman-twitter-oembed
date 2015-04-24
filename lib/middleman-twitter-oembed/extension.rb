require 'middleman-twitter-oembed/helpers'
require 'middleman-twitter-oembed/interface'

module Middleman
  module TwitterOembed
    class Extension < Middleman::Extension
      option :enable_convert, true
      option :convert_regex, %r{https?://twitter.com/[a-zA-Z0-9_]+/status/(\d+)}
      option :omit_script, false
      option :use_cache, true
      option :cache_dir, ".caches/twitter_oembed"
      
      self.defined_helpers = [::Middleman::TwitterOembed::Helpers]

      attr_reader :interface
      
      def initialize(app, options_hash={}, &block)
        super
        #app.set :twitter_oembed_settings, options

        opts = {
          use_cache: options.use_cache,
          cache_dir: options.cache_dir,
          omit_script: options.omit_script
        }
        @interface = Middleman::TwitterOembed::Interface.new(opts)
        
        extension = self
        app.before_render do |body|
          extension.convert(body)
        end
      end

      def convert(body)
        return unless options.enable_convert
        
        #regex = %r{https?://twitter.com/[a-zA-Z0-9_]+/status/(\d+)}
        regex = options.convert_regex
        body.gsub(regex){
          res = @interface.get_tweet($1)
          res['html']
        }
      end
    end ## class Extension
  end
end
