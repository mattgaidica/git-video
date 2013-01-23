class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  #before_filter :require_login

  private
  
  def require_login
    redirect_to login_path if !current_user && request.fullpath != login_path
    redirect_to root_path if current_user && request.fullpath == login_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
