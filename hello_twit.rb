require 'yaml'
require 'sinatra/base'
require 'sinatra-twitter-oauth'
require 'appengine-apis/urlfetch'
require "patch_for_appengine_jruby_twitter"

class HelloTwit < Sinatra::Base
  register Sinatra::TwitterOAuth

  set :twitter_oauth_config, YAML.load_file('twitter_conf.yml')

  get '/' do
    login_required
    "Hello #{user.name}, <a href='/twit'>twit!</a>"
  end

  get "/twit" do
    login_required
    user.client.update("Hey! #{Time.now}")
    redirect "http://twitter.com/#{user.screen_name}"
  end
end
