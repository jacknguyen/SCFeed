class WelcomeController < ApplicationController
  http_basic_authenticate_with name: ENV['USERNAME'], password: ENV['PASSWORD']
  before_action :configure_twitter, only: :search

  def index
  end

  def search
    @user = search_params[:user]
    @tweets = @client.user_timeline(@user, {count: 25})

  end

  private
  def search_params
    params.permit(:user)
  end

  def configure_twitter
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
      config.bearer_token        = ENV['TWITTER_BEARER_TOKEN']
    end
  end
end