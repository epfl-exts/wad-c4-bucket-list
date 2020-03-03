module ApplicationHelper
  def can_edit?(goal)
    case current_user.role
    when 'admin' then true
    when 'registered' then goal.user == current_user
    else false
    end
  end
end
