module ApplicationHelper
  def attempted_task?(task)
    task.submissions.where(user: current_user).count != 0
  end
end
