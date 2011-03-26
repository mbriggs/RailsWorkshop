require 'spec_helper'

describe HomeController do
  let!(:user) { User.create! :username => "user", :password => "pass", :email => "email" }

  describe "GET 'index'" do
    it "should show if not logged in" do
      session[:user].should be_nil

      get :index

      response.should be_successful
      response.should render_template "index"
    end

    it "should redirect if logged in" do
      session[:user] = user

      get :index

      response.should redirect_to user_path(user)
    end
  end

  describe "POST 'login'" do
    it "should login with good credentials" do
      post :login, :username => user.username, :password => user.password

      session[:user].should == user
      response.should redirect_to root_path
    end

    it "should not login without good credentials" do
      post :login, :username => user.username, :password => "wrong_password"

      session[:user].should be_nil
      response.should redirect_to root_path
    end
  end

  describe "GET 'logout'" do
    it "should logout user" do
      session[:user] = user

      get :logout

      session[:user].should be nil
      response.should redirect_to root_path
    end
  end
end
