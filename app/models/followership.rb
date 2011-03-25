class Followership < ActiveRecord::Base
  belongs_to :follower
  belongs_to :following
end
