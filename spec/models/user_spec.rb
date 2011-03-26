require 'spec_helper'

describe User do
  it "should have a username, password and email" do
    user = User.new
    user.should_not be_valid
    user.errors[:username].should_not be_empty
    user.errors[:password].should_not be_empty
    user.errors[:email].should_not be_empty
  end

  it "should have a unique username and email" do
    User.create! :username => "a", :password => "b", :email => "c@d.e"
    user = User.new :username => "a", :password => "b", :email => "c@d.e"
    user.should_not be_valid
    user.errors[:username].should_not be_empty
    user.errors[:email].should_not be_empty
    user.errors[:password].should be_empty
  end

  context "followership" do

    let!(:tweeter) { User.create! :username => "a", :password => "a", :email => "a@a.com" }
    let!(:follower) { User.create! :username => "b", :password => "b", :email => "b@b.com" }
    let!(:following) { User.create! :username => "c", :password => "c", :email => "c@c.com" }


    before :all do
      Followership.create! :follower => follower, :following => tweeter
      Followership.create! :follower => tweeter, :following => following
      
    end

    subject { tweeter }

    its("followers") { should eql [follower] }
    its("followings") { should eql [following] }

    it "should follow and unfollow user" do
      user_1 = User.create! :username => "aa", :password => "aa", :email => "aa@aa.com"
      user_2 = User.create! :username => "bb", :password => "bb", :email => "bb@bb.com"
      
      user_1.follow! user_2
      user_1.followings.should include user_2
      user_2.followers.should include user_1

      user_1.unfollow! user_2
      user_1.followings.should_not include user_2
      user_2.followings.should_not include user_1
    end

    context "messaging" do
      let!(:tweet_1) { Tweet.create! :user => tweeter, :message => "tweet" }
      let!(:tweet_2) { Tweet.create! :user => tweeter, :message => "tweet" }
      let!(:tweet_3) { Tweet.create! :user => tweeter, :message => "tweet" }
      let!(:following_tweet) { Tweet.create! :user => following, :message => "tweet" }
      let!(:follower_tweet) { Tweet.create! :user => follower, :message => "tweet" }

      before :all do
        # initialize tweets in order
        [tweet_3, follower_tweet, tweet_2, following_tweet, tweet_1]
      end

      its("tweets") { should == [tweet_1, tweet_2, tweet_3] }
      its("wall") { should == [tweet_1, following_tweet, tweet_2, tweet_3] }
    end

  end
end
