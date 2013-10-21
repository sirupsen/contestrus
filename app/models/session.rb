class Session
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user=(user)
    @user = user
    session[:user_id] = user.id
  end
end
