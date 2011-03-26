class HomeController < ApplicationController
  def index
    redirect_to user_path(current_user) if current_user
  end

  def login
    session[:user] = User.find_by_username_and_password \
      params[:username], params[:password] 

    redirect_to root_path
  end

  def logout
    session[:user] = nil
    redirect_to root_path
  end
end
