class CreateMarks < ActiveRecord::Migration
  def self.up
    create_table :marks do |t|
      t.integer :stamp_id
      t.boolean :skip, :default => false, :null => false
      t.date :marked_on
      t.timestamps
    end
  end
  
  def self.down
    drop_table :marks
  end
end
