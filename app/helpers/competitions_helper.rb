module CompetitionsHelper
  def competition_status_class(competition)
    if competition.tasks.all? { |task| task.passed?(current_user) }
      "success"
    else
      "warning"
    end
  end

  def task_status_class(task, user = current_user)
    if task.passed?(user)
      "success"
    elsif current_user.submissions.where(task_id: task.id).empty?
      "info"
    else
      "warning"
    end
  end

  def task_status_human(task, user = current_user)
    if task.passed?(user)
      "Passed"
    elsif current_user.submissions.where(task_id: task.id).empty?
      "Not attempted"
    else
      "Attempted"
    end
  end

  def admin_or_expired?(competition)
    !@competition.ongoing? || current_user.admin?
  end

  def task_status_badge(task, user = current_user)
    "<span class='label label-#{task_status_class(task, user)}'>#{task_status_human(task, user)}</span>".html_safe
  end
end
