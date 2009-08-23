class AddCurrentStampIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :current_stamp_id, :integer
  end

  def self.down
    remove_column :users, :current_stamp_id
  end
end
