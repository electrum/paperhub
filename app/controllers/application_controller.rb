class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_session

private
  def load_session
    if session[:user_id].present?
      @session_user = User.find_by_user_id(session[:user_id])
    end
  end
end
