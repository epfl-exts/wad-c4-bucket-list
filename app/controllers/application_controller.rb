class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def ensure_authenticated
    unless logged_in?
      redirect_to login_path
    end
  end
  
  def logged_in?
    session[:user_id].present?
  end
end
