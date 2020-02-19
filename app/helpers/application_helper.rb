module ApplicationHelper
  def can_edit?(goal)
    goal.user == current_user
  end
end
