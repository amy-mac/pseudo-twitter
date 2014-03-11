class SessionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]
  def new

  end

  def create
    user = User.where(['name LIKE ?', params[:session][:name]])

    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      redirect_to user_path(user.name)
    else
      flash.now.alert = user.errors.full_messages
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
