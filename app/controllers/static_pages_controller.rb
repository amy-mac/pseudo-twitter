class StaticPagesController < ApplicationController
  skip_before_filter :authorize

  def index
    if signed_in?
      @feed = current_user.feed.paginate(page: params[:page], per_page: 50)
      @tweet = current_user.tweets.build if signed_in?
    end
  end

end
