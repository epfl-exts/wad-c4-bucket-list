class IdeasController < ApplicationController
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
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    if(@idea.update(ideas_resource_params))
      redirect_to account_ideas_path
    else
      render 'edit'
    end
  end

  private

  def ideas_resource_params
    params.require(:idea).permit(:title, :done_count, :photo_url, :description)
  end
end
