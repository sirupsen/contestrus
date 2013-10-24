class SessionsController < ApplicationController
  skip_before_filter :require_user
  before_filter :to_user, only: [:new]

  def new
    @user = User.new
  end

  def create
    if user = current_session.login(params[:user][:username], params[:user][:password])
      redirect_to user_path(user)
    else
      flash[:error] = "Invalid credentials."
      render :new
    end
  end

  def destroy
    current_session.user = nil
    redirect_to root_path
  end

  private
  def to_user
    redirect_to user_path(current_user) if current_user
  end
end
