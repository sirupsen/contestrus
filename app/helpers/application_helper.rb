module ApplicationHelper
  def task_badge(task)
    if completed_task?(task) 
      "<span class='label label-success'>Passed</span>"
    elsif attempted_task?(task)
      "<span class='label label-warning'>Attempted</span>"
    end.html_safe
  end

  def render_markdown(markdown)
    Markdown.render(markdown).html_safe
  end

  def time_left_badge(competition)
    if competition.always_open?
      nil
    elsif competition.open?
      seconds = (competition.end_at - Time.now).to_i

      hours = seconds / 3600
      seconds -= hours * 3600

      minutes = seconds / 60
      seconds -= minutes * 60

      "<span class='badge badge-info'>#{hours}:#{minutes}:#{seconds}</span>".html_safe
    else
      "<span class='label label-warning'>Completed</span>".html_safe
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
