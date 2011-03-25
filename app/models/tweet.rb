class Tweet < ActiveRecord::Base
  belongs_to :user

  validates_length_of :message, :maximum => 140
  validates_presence_of :message
end
