class CreateMonthCaches < ActiveRecord::Migration
  def self.up
    create_table :month_caches do |t|
      t.integer :stamp_id
      t.integer :positive_points
      t.integer :negative_points
      t.integer :position
      t.integer :score
      t.date :for_month
      t.timestamps
    end
  end
  
  def self.down
    drop_table :month_caches
  end
end
