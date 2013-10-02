class SessionController < ApplicationController
  skip_before_filter :require_user
  before_filter :to_competitions, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_username(params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to competitions_path
    else
      flash[:error] = "Invalid credentials."
      render :new
    end
  end

  def sign_out
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def to_competitions
    redirect_to competitions_path if current_user
  end
end
