class GoalsController < ApplicationController
  before_action :ensure_authenticated

  def create
    user = current_user
    @idea = Idea.find(params[:idea_id])
    user.goals << @idea
    respond_to do |format|
      format.html { redirect_to idea_path(@idea) }
      format.js { render 'create' }
    end
  end
end
