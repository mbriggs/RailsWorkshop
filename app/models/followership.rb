class Followership < ActiveRecord::Base
  belongs_to :follower, :class_name => "User"
  belongs_to :following, :class_name => "User"

  # TODO Add validations

  validate do |record|
    errors.add :base, "Follower and following are the same user" if 
      record.follower == record.following
  end
end
