class SessionsController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]

  def new

  end

  def create
    user = User.where(['name LIKE ?', params[:session][:name]]).first

    if user && user.authenticate(params[:session][:password])
      sign_in(user)
      redirect_to root_path 
    else
      flash.now.alert = "Sorry, your email or password is incorrect"
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
