class UsersController < ApplicationController
  def index
    # FIXME Order by date
    @users = User.all
  end

  def show
    @user = User.find params[:id]

    # FIXME Show the right tweets
    @tweets = Tweet.all
  end

  def create
    @user = User.new params[:user]

    # FIXME Save the user
    if true
      session[:user] = @user
      redirect_to @user
    else
      render "home/index", :layout => 'home'
    end
  end

  def follow
    @user = User.find params[:id]

    # FIXME Follow the user!

    redirect_to @user
  end

  def unfollow
    @user = User.find params[:id]

    # FIXME Follow the user!

    redirect_to @user
  end
end
