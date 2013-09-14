class SessionController < ApplicationController
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
end
