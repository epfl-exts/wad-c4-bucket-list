class GoalsController < ApplicationController
  before_action :ensure_authenticated

  def create
    user = current_user
    idea = Idea.find(params[:idea_id])
    user.goals << idea
    redirect_to idea_path(idea)
  end
end
