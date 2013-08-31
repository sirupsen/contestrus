class SessionController < ApplicationController
  def new
    @user = User.new
  end

  # TODO: This is pretty fucking shitty
  def create
    @user = User.find_by_username(params[:user][:username])

    if !@user
      @user = User.create(params[:user].permit(:username, :password))

      if @user.valid?
        session[:user_id] = @user.id
        redirect_to competitions_path
      else
        render :new
      end
    elsif @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to competitions_path
    else
      flash[:error] = "Invalid credentials."
      render :new
    end
  end
end
