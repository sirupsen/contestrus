class UsersController < ApplicationController
  skip_before_filter :require_user, except: [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      current_session.user = @user
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private
  def user_params
    params[:user].permit(:email, :username, :password)
  end
end
