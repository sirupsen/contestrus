class CompetitionsController < ApplicationController
  before_filter :require_admin_for_ongoing, only: [:leaderboard]

  def index
    @competitions = Competition.all
  end

  def show
    @competition = Competition.find(params[:id]) 
  end

  def leaderboard
    @competition = Competition.find(params[:id])
    @tasks = @competition.tasks
    # if you see this, fix this.
    @users = User.joins("INNER JOIN submissions ON submissions.task_id IN (#{@tasks.map(&:id).join(",")})").uniq { |u| user.id }
    @users = @users.sort_by { |u| u.submissions.where(task_id: @tasks.map(&:id)).select { |s| s.passed? }.uniq { |s| s.task_id } }.reverse
  end

  protected
  def require_admin_for_ongoing
    competition = Competition.find(params[:id])

    if competition.ongoing?
      unless current_user.admin?
        render :text => "Permission denied", status: 403
        return false
      end
    end
  end
end
