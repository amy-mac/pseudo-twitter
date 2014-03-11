module SessionsHelper

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= begin
      User.find(session[:user_id]) rescue nil
    end
  end

  def sign_in(user)
    session[:user_id] = user.id
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      session[:return_to] = request.url
      redirect_to new_session_path, alert: "Please sign in to see this page"
    end
  end

  def sign_out
    self.current_user = nil
    reset_session
  end
end
