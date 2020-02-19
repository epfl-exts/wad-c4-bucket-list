class AccountController < ApplicationController
  before_action :ensure_authenticated

  def ideas
    @ideas = Idea.all
  end

  def ensure_authenticated
    unless logged_in?
      redirect_to login_path
    end
  end
end
