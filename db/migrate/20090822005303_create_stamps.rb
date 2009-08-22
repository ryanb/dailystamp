class CreateStamps < ActiveRecord::Migration
  def self.up
    create_table :stamps do |t|
      t.integer :user_id
      t.string :name
      t.boolean :private
      t.timestamps
    end
  end
  
  def self.down
    drop_table :stamps
  end
end
