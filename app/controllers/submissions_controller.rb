class SubmissionsController < ApplicationController
  def create
    submission = current_user.submissions.build(
      source: params[:submission][:source] && params[:submission][:source].read,
      task_id: params[:task_id]
    )

    if submission.save
      flash[:notice] = "Submitted task!"
      redirect_to task_path(params[:task_id])
    else
      flash[:error] = "Error submitting task"
      redirect_to task_path(params[:task_id])
    end
  end

  def show
    @submission = current_user.submissions.find(params[:id])
  end
end
