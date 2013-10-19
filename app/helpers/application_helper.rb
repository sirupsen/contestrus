require 'pry'

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

  private
  def completed_task?(task)
    task.passed?(current_user) if current_user
  end

  def attempted_task?(task)
    task.submissions.where(user_id: current_user.id).count != 0 if current_user
  end
end
