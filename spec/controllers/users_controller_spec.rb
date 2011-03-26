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
    let!(:current) { User.create! :username => "current", :password => "pass", :email => "current@example.com" }
    let!(:follower) { User.create! :username => "follower", :password => "pass", :email => "follower@example.com" }
    let!(:current_tweet) { current.tweets.create! :message => "hello" }
    let!(:follower_tweet) { follower.tweets.create! :message => "hi" }

    before :all do
      Followership.create! :follower => follower, :following => current
      [follower_tweet, current_tweet]
    end

    it "should assign specified user" do
      get :show, :id => user_1.id

      response.should be_successful
      response.should render_template "show"
      assigns(:user).should == user_1
    end

    it "should show wall tweets for current user" do
      session[:user] = current
      get :show, :id => current

      assigns(:tweets).should == [current_tweet, follower_tweet]
    end

    it "should show user tweets for other users" do
      session[:user] = current
      p "now"
      get :show, :id => follower

      assigns(:tweets).should == [follower_tweet]
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

  describe "POST 'create'" do
    it "should create user with valid parameters" do
      User.find_by_username("new_user").should be_nil

      post :create, :user => { :username => "new_user", :password => "pass", :email => "new_user@example.com" }

      user = User.find_by_username("new_user")

      user.should_not be_nil

      session[:user].should == user
      response.should redirect_to user_path(user)
    end

    it "should not create user without valid parameters" do
      User.find_by_username("another_user").should be_nil

      post :create, :user => { :username => "another_user" }

      User.find_by_username("another_user").should be_nil 

      response.should render_template "home/index"
    end
  end
end
