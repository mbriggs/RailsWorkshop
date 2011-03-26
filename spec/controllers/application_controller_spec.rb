require 'spec_helper'

describe ApplicationController do
  describe "current_user" do
    let!(:user) { User.create! :username => "user", :password => "pass", :email => "email" }

    it "should assign current user" do
      session[:user] = user

      controller.send(:current_user)

      assigns(:current_user).should == user
    end

    it "should unassign current user" do
      session[:user] = nil

      controller.send(:current_user)

      assigns(:current_user).should be nil
    end
  end
end
