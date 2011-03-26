require 'spec_helper'

describe TweetsController do
  describe "POST 'create'" do
    it "should create tweet for current user" do
      user = User.create! :username => "user", :password => "pass", :email => "email@email.com"
      session[:user] = user

      post :create, :tweet => { :message => "hello" }

      user.tweets.count.should be 1
      response.should redirect_to user_path(user)
    end
  end
end
