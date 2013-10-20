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
    @users = @competition.leaderboard
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
