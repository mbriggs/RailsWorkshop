require 'spec_helper'

describe Tweet do
  its "message cannot be blank" do
    tweet = Tweet.new :message => " "
    tweet.should_not be_valid
    tweet.errors[:message].should_not be_empty
  end

  its "message cannot be longer than 140 characters" do
    tweet = Tweet.new :message => "."*141
    tweet.should_not be_valid
    tweet.errors[:message].should_not be_empty
  end
end
