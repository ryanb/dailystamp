class AddColorToStamps < ActiveRecord::Migration
  def self.up
    add_column :stamps, :color, :string
  end

  def self.down
    remove_column :stamps, :color
  end
end
