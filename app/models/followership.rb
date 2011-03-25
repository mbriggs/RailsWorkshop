class Followership < ActiveRecord::Base
  belongs_to :follower, :class_name => "User"
  belongs_to :following, :class_name => "User"

  validates_presence_of :follower
  validates_presence_of :following

  validates_uniqueness_of :following_id, :scope => :follower_id

  validate do |record|
    errors.add :base, "Follower and following are the same user" if 
      record.follower == record.following
  end
end
