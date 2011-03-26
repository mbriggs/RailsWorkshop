class HomeController < ApplicationController
  def index
    @user = User.new

    # FIXME Redirect them to their home page if they are logged in
  end

  def login
    # FIXME get the user!
    session[:user] = User.find_by_username_and_password \
      params[:password], params[:username] 

    redirect_to root_path
  end

  def logout
    # FIXME drop the session
    redirect_to root_path
  end
end
