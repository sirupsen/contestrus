module CompetitionsHelper
  def competition_status_class(competition)
    if competition.tasks.all? { |task| task.passed?(current_user) }
      "success"
    else
      "warning"
    end
  end

  def task_status_class(task)
    if task.passed?(current_user)
      "success"
    elsif current_user.submissions.where(task_id: task.id).empty?
      "info"
    else
      "warning"
    end
  end

  def task_status_human(task)
    if task.passed?(current_user)
      "Passed"
    elsif current_user.submissions.where(task_id: task.id).empty?
      "Not attempted"
    else
      "Attempted"
    end
  end

  def task_status_badge(task)
    "<span class='label label-#{task_status_class(task)}'>#{task_status_human(task)}</span>".html_safe
  end
end
