class CompetitionsController < ApplicationController
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
    @users = User.joins("INNER JOIN submissions ON submissions.task_id IN (#{@tasks.map(&:id).join(",")})")
  end
end
