class User < ActiveRecord::Base
  acts_as_authentic
  has_many :stamps
  has_many :marks, :through => :stamps
  has_many :stamp_images
  belongs_to :current_stamp, :class_name => "Stamp"
  
  def unused_color
    (STAMP_COLORS - stamps.map(&:color)).first
  end
end
