class UsersController < ApplicationController
  skip_before_filter :authorize, only: [:show, :new, :create]

  def show
    @user = User.find_by_name(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])

    if @user.errors.empty?
      sign_in(@user)
      redirect_to user_path(@user.name), notice: 'Thanks for signing up!'
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
end
