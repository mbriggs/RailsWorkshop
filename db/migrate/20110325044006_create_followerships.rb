class CreateFollowerships < ActiveRecord::Migration
  def self.up
    create_table :followerships do |t|
      t.belongs_to :follower
      t.belongs_to :following

      t.timestamps
    end
  end

  def self.down
    drop_table :followerships
  end
end
