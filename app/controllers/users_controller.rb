class UsersController < ApplicationController
  skip_before_filter :authorize, only: [:show, :new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.includes(:tweets).where(['name LIKE ?', params[:id]]).first
    @tweet = current_user.tweets.build if signed_in?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])

    if @user.save
      sign_in(@user)
      redirect_to user_path(@user), notice: 'Thanks for signing up!'
    else
      flash.now.alert = @user.errors.full_messages[0]
      render :new
    end

  end

  def edit

  end

  def update

  end

  def destroy

  end

  def followers
    @title = "Followers"
    @user = User.where(['name LIKE ?', params[:id]]).first
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def following
    @title = "Following"
    @user = User.where(['name LIKE ?', params[:id]]).first
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
end
