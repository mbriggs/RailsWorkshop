require 'spec_helper'

describe UsersController do
  let!(:user_1) { User.create! :username => "user_1", :password => "pass", :email => "user_1@example.com" }
  let!(:user_2) { User.create! :username => "user_2", :password => "pass", :email => "user_2@example.com" }
  let!(:user_3) { User.create! :username => "user_3", :password => "pass", :email => "user_3@example.com" }

  before :all do
    # initialize users in random order
    [user_3, user_2, user_1]
  end

  describe "GET 'index'" do
    it "should assign all users in alphabetical order" do
      get :index

      response.should be_successful
      response.should render_template "index"
      assigns(:users).should == [user_1, user_2, user_3]
    end
  end

  describe "GET 'show'" do
    it "should assign specified user" do
      get :show, :id => user_1.id

      response.should be_successful
      response.should render_template "show"
      assigns(:user).should == user_1
    end
  end

  describe "PUT 'follow'" do
    it "should make current user follow user" do
      session[:user] = user_1
      put :follow, :id => user_2

      user_1.followings.should include user_2
      response.should redirect_to user_path(user_2)
    end
  end

  describe "PUT 'unfollow'" do
    it "should make current user unfollow user" do
      user_1.follow! user_3
      session[:user] = user_1
      put :unfollow, :id => user_3

      user_1.followings.should_not include user_3
      response.should redirect_to user_path(user_3)
    end
  end
end
