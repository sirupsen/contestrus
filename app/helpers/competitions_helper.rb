module CompetitionsHelper
  def task_status_class(task)
    if task.passed?(current_user)
      "success"
    elsif current_user.submissions.where(task_id: task.id) == 0
      "info"
    else
      "error"
    end
  end

  def competition_status_class(competition)
    if competition.tasks.all? { |task| task.passed?(current_user) }
      "success"
    else
      "warning"
    end
  end
end
