class HomeController < ApplicationController
  def index
    @user = User.new

    # FIXME Redirect them to their home page if they are logged in
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
