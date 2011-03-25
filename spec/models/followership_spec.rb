require 'spec_helper'

describe Followership do
  let!(:user) { User.new }
  let!(:tweet) { Tweet.new }

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

  it "duplicates should not be allowed" do
    another_user = User.new
    Followership.create! :follower => user, :following => another_user

    followership = Followership.new :follower => user, :following => another_user
    followership.should_not be_valid
  end
end
