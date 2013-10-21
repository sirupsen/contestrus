class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_user
  def require_user
    unless current_user
      flash[:notice] = "You must be signed in to access that page."
      redirect_to new_sessions_path
      return false
    end
  end

  helper_method :current_session
  def current_session
    @current_session ||= Session.new(session)
  end

  helper_method :current_user
  def current_user
    current_session.user
  end

  def require_admin
    unless current_user.admin?
      flash[:notice] = "Go away."
      render :nothing => true, status: 403
      return false
    end
  end
end
