module ApplicationHelper
  def task_status_human(task, user = current_user)
    if user.submissions.passed.for_task(task).during_competition.any?
      "Passed"
    elsif user.submissions.for_task(task).during_competition.any?
      "Attempted"
    else
      "Not attempted"
    end
  end

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

  def task_status_badge(task, user = current_user, show_not_attempted = false)
    human_status = task_status_human(task, user)
    return nil if human_status == "Not attempted" && !show_not_attempted 

    "<span class='label label-#{task_status_class(task, user)}'>#{human_status}</span>".html_safe
  end

  def render_markdown(markdown)
    Markdown.render(markdown).html_safe
  end

  def time_left_badge(competition)
    if competition.always_open?
      nil
    elsif Time.now < competition.start_at
      seconds = (competition.start_at - Time.now).to_i
      "<span class='badge badge-info'>#{seconds / 3600}:#{seconds / 60 % 60}:#{seconds % 60}</span>".html_safe
    elsif competition.ongoing?(Time.now)
      seconds = (competition.end_at - Time.now).to_i
      "<span class='badge badge-warning'>#{seconds / 3600}:#{seconds / 60 % 60}:#{seconds % 60}</span>".html_safe
    end
  end

  private
  def completed_task?(task)
    task.passed?(current_user) if current_user
  end

  def attempted_task?(task)
    task.submissions.where(user_id: current_user.id).count != 0 if current_user
  end
end
