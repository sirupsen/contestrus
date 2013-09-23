class TasksController < ApplicationController
  def show
    @task        = Task.find(params[:id])
    @submission  = Submission.new(task_id: @task.id, user_id: params[:user_id])
    @submissions = current_user.submissions.where(task_id: @task.id)
  end
end
