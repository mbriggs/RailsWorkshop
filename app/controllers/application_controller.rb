class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    # FIXME get the user from the session
    @current_user ||= nil
  end
end
