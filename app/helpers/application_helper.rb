module ApplicationHelper
  def task_status_human(task, user = current_user)
    if user.submissions.completed.for_task(task).during_competition.any?
      "Passed"
    elsif user.submissions.partial.for_task(task).during_competition.any?
      "Partial"
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
    when "Partial"
      "warning"
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

  def task_points_badge(task, user = current_user)
    submission = user.submissions.for_task(task)
      .during_competition
      .max { |a,b| a.points <=> b.points }

    return "" unless submission

    html_label = "success" if submission.points == submission.task.groups.inject(0) { |sum, g| sum + g.points }
    html_label ||= "warning"

    "<span class='label label-#{html_label}'>#{submission.points}</span>".html_safe
  end

  def render_markdown(markdown)
    Markdown.render(markdown).html_safe
  end

  def time_left_badge(competition)
    return nil if competition.always_open? || competition.expired? # like 7-11

    badge_class =
      if Time.now < competition.start_at
        seconds = (competition.start_at - Time.now).to_i
        "badge-info"
      elsif competition.ongoing?
        seconds = (competition.end_at - Time.now).to_i
        "badge-warning"
      end

    sprintf("<span class='badge #{badge_class}'>%d:%02d:%02d</span>", seconds / 3600, seconds / 60 % 60, seconds % 60).html_safe
  end

  private
  def completed_task?(task)
    task.passed?(current_user) if current_user
  end

  def attempted_task?(task)
    task.submissions.where(user_id: current_user.id).count != 0 if current_user
  end
end
