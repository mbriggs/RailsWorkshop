class TweetsController < ApplicationController
  def create
    current_user.tweets.create! params[:tweet]

    redirect_to current_user
  end
end
