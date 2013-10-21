class TasksController < ApplicationController
  before_filter :visible_contest, except: [:index]

  def index
    @tasks = Task.all
  end

  def show
    @task        = Task.find(params[:id])
    @submission  = Submission.new(task_id: @task.id, user_id: params[:user_id])
    @submissions = current_user.submissions.where(task_id: @task.id).order("id DESC")
  end

  private
  def visible_contest
    unless Task.find(params[:id]).competition.visible?
      render :nothing => true, status: 403
      return false
    end
  end
end
