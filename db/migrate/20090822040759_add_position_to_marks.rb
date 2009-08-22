class AddPositionToMarks < ActiveRecord::Migration
  def self.up
    add_column :marks, :position_x, :integer
    add_column :marks, :position_y, :integer
  end

  def self.down
    remove_column :marks, :position_y
    remove_column :marks, :position_x
  end
end
