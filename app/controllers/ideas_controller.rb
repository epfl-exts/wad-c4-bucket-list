class IdeasController < ApplicationController
  before_action :ensure_authenticated, only: [:new, :create, :edit, :update]
  before_action :load_idea, only: [:edit, :update]
  before_action :ensure_owner, only: [:edit, :update]

  def index
    @search_term = params[:q]
    @ideas = Idea.search(@search_term)
    logger.info "Search completed using #{@search_term}"
  end

  def show
    @idea = Idea.find(params[:id])
    @comment = Comment.new
    @display_add_comment = session[:user_id].present?

    if(session[:user_id])
      @user = User.find(session[:user_id])
      @disable_add_goal = @user.goals.exists?(@idea.id)
    else
      @user = nil
    end
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new ideas_resource_params
    user = User.find(session[:user_id])
    @idea.user = user
    if @idea.save
      redirect_to ideas_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if(@idea.update(ideas_resource_params))
      redirect_to account_ideas_path
    else
      render 'edit'
    end
  end

  private

  def ensure_owner
    if(@idea.user == current_user)
      return
    end

    redirect_to(account_path)
  end

  def ideas_resource_params
    params.require(:idea).permit(:title, :done_count, :photo_url, :description)
  end

  def load_idea
    @idea = Idea.find(params[:id])
  end
end
