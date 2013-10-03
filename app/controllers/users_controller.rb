class UsersController < ApplicationController
  skip_before_filter :require_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to competitions_path
    else
      render :new
    end
  end

  private
  def user_params
    params[:user].permit(:email, :username, :password)
  end
end
