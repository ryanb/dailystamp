class AddStampImageIdToStamps < ActiveRecord::Migration
  def self.up
    add_column :stamps, :stamp_image_id, :integer
  end

  def self.down
    remove_column :stamps, :stamp_image_id
  end
end
