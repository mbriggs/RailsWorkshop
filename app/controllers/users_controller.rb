class UsersController < ApplicationController
  def index
    @users = User.order("username ASC")
  end

  def show
    @user = User.find params[:id]

    @tweets = current_user == @user ? @user.wall : @user.tweets
  end

  def create
    @user = User.new params[:user]

    if @user.save
      session[:user] = @user
      redirect_to @user
    else
      render "home/index"
    end
  end

  def follow
    @user = User.find params[:id]

    current_user.follow! @user

    redirect_to @user
  end

  def unfollow
    @user = User.find params[:id]

    current_user.unfollow! @user

    redirect_to @user
  end
end
