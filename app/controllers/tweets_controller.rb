class TweetsController < ApplicationController
  skip_before_filter :authorize, only: [:show]

  def index
    redirect_to user_path(current_user.name)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    new_tweet = current_user.tweets.create(params[:tweet])

    if new_tweet.save
      redirect_to user_path(current_user.name)
    else
      flash.alert = "Oops, something went wrong"
      redirect_to root_path
    end
  end

  def show
    @tweet = Tweet.includes(:user).find(params[:id])
  end

  def edit
    @tweet = current_user.tweets.find(params[:id])
  end

  def update
    @tweet = current_user.tweets.find(params[:id])

    @tweet.update_attributes(params[:tweet])

    if @tweet.save
      redirect_to tweet_path(@tweet)
    else
      flash.now.alert = "Oops, your tweet is probably too long."
      render :edit
    end
  end

  def destroy
    current_user.tweets.find(params[:id]).destroy()
    redirect_to user_path(current_user.name)
  end
end
