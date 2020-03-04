class UsersController < ApplicationController
  before_action :ensure_admin, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to ideas_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
  end

  private

  def ensure_admin
    redirect_to account_path unless current_user.role == "admin"
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
