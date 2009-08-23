class StampImage < ActiveRecord::Base
  attr_accessible :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at
  belongs_to :user
  has_attached_file :photo, :url  => "/assets/stamp_images/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/stamp_images/:id/:style/:basename.:extension"
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 3.megabytes
  validates_presence_of :user_id
end
