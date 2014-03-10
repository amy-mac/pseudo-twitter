class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :authorize
  
  def authorize
    signed_in_user
  end

  def handle_unverified_requests
    sign_out
    super
  end
end
