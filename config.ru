require 'appengine-rack'

AppEngine::Rack.configure_app(
    :application => "hello-twit-rb",
    :precompilation_enabled => true,
    :version => "1")
ENV['RACK_ENV'] = AppEngine::Rack.environment
require 'hello_twit'

require 'sinatra'
configure :development do
  class Sinatra::Reloader < ::Rack::Reloader
    def safe_load(file, mtime, stderr)
      if File.expand_path(file) =~ /hello_twit.rb/
        HelloTwit.reset!
        stderr.puts "#{self.class}: reseting routes"
      end
      super
    end
  end
  use Sinatra::Reloader
end

run HelloTwit.new
