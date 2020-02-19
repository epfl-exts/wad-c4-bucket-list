class AccountController < ApplicationController
  before_action :ensure_authenticated

  helper_method :current_user

  def ideas
    user = User.find(session[:user_id])
    @ideas = user.ideas
  end

  def ensure_authenticated
    unless logged_in?
      redirect_to login_path
    end
  end
  
  def current_user
    User.find(session[:user_id])
  end
end
