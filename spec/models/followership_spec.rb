require 'spec_helper'

describe Followership do
  let!(:user) { User.create! :username => "aa", :password => "aa", :email => "aa@aa.com" }
  let!(:tweet) { Tweet.create! :user => user, :message => "test" }

  its "follower should always be set" do
    followership = Followership.new :follower => nil
    
    followership.should_not be_valid
    followership.errors[:follower].should_not be_empty
  end

  its "follower should be a user" do
    lambda {
      Followership.new :follower => user
    }.should_not raise_error NameError
  end

  its "following should always be set" do
    followership = Followership.new :following => nil
    
    followership.valid?.should be_false
    followership.errors[:following].should_not be_empty
  end

  its "following should be a user" do
    lambda {
      Followership.new :following => user
    }.should_not raise_error NameError
  end

  its "follower and following should not be the same user" do
    followership = Followership.new :follower => user, :following => user
    followership.should_not be_valid
  end

  context "duplicates" do
    let!(:another_user) { User.new :username => "bb", :password => "bb", :email => "bb@bb.com" }
    let!(:different_user) { User.new :username => "cc", :password => "cc", :email => "cc@cc.com" }

    before :all do
      Followership.create! :follower => user, :following => another_user
    end

    it "should not allow duplicates" do
      followership = Followership.new :follower => user, :following => another_user
      followership.should_not be_valid
    end

    it "should allow multiple followers per user" do
      followership = Followership.new :follower => different_user, :following => another_user
      followership.should be_valid
      
    end

    it "should allow multiple followings per user" do
      followership = Followership.new :follower => user, :following => different_user
      followership.should be_valid
    end
  end
end
