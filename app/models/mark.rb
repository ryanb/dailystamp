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
    if stamp
      stamp.update_attribute(:score_cache, nil)
      MonthCache.delete_all(["for_month >= ? and stamp_id=?", marked_on.beginning_of_month, stamp.id])
    end
  end
end
