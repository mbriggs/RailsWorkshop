class User < ActiveRecord::Base
  has_many :follower_followerships, :foreign_key => "following_id", :class_name => "Followership"
  has_many :following_followerships, :foreign_key => "follower_id", :class_name => "Followership"

  has_many :followers, :through => :follower_followerships, :class_name => "User"
  has_many :followings, :through => :following_followerships, :class_name => "User"

  has_many :tweets, :order => "created_at DESC"

  # TODO Add validations

  def wall
    # FIXME Get user's and follower's tweets
    Tweet.all
  end

  def follow! user
    # FIXME Follow a user
  end

  def unfollow! user
    # FIXME Unfollow a user
  end
end
