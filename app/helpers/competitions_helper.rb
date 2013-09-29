module CompetitionsHelper
  def task_status_class(task)
    if task.passed?(current_user)
      "success"
    elsif current_user.submissions.where(task_id: task.id).empty?
      "info"
    else
      "warning"
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
