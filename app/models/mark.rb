class Mark < ActiveRecord::Base
  attr_accessible :skip, :marked_on, :position_x, :position_y
  belongs_to :stamp
  after_save :reset_score
  after_destroy :reset_score
  
  def image_path
    stamp && stamp.stamp_image && stamp.stamp_image.photo.url(stamp.color)
  end
  
  private
  
  def reset_score
    stamp.update_attribute(:score_cache, nil) if stamp
  end
end
