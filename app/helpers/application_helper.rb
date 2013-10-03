module ApplicationHelper
  def completed_task?(task)
    task.passed?(current_user) if current_user
  end

  def attempted_task?(task)
    task.submissions.where(user_id: current_user.id).count != 0 if current_user
  end
end
