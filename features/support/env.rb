ENV["TEST"] = "true"
ENV["AUTOLOAD_SPROCKETS"] = "false"

require 'simplecov'
SimpleCov.start do
  add_filter "/features/"
end

require 'coveralls'

Coveralls.wear!


PROJECT_ROOT_PATH = File.dirname(File.dirname(File.dirname(__FILE__)))
require 'middleman-core'
require 'middleman-core/step_definitions'
require 'pry-byebug'
require File.join(PROJECT_ROOT_PATH, 'lib', 'middleman-twitter-oembed')
