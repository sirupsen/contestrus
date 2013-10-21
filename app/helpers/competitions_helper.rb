module CompetitionsHelper
  def task_status_class(task, user = current_user)
    case task_status_human(task, user)
    when "Passed"
      "success"
    when "Attempted"
      "warning"
    when "Not attempted"
      "info"
    end
  end

  def task_status_badge(task, user = current_user)
    "<span class='label label-#{task_status_class(task, user)}'>#{task_status_human(task, user)}</span>".html_safe
  end
end
