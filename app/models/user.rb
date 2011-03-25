class User < ActiveRecord::Base
  has_many :follower_followerships, :foreign_key => "following_id", :class_name => "Followership"
  has_many :following_followerships, :foreign_key => "follower_id", :class_name => "Followership"

  has_many :followers, :through => :follower_followerships, :class_name => "User"
  has_many :followings, :through => :following_followerships, :class_name => "User"

  has_many :tweets, :order => "created_at DESC"

  validates_presence_of :username, :password, :email
  validates_uniqueness_of :username, :email

  def wall
    Tweet.
      where( :user_id => [self] + followings ).
      order( "created_at DESC" )
  end

  def follow! user
    followings.push user
  end

  def unfollow! user
    followings.delete user
  end
end
