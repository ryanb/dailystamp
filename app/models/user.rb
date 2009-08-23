class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.openid_required_fields = [:nickname, :email]
  end
  has_many :stamps
  has_many :marks, :through => :stamps
  has_many :stamp_images
  belongs_to :current_stamp, :class_name => "Stamp"
  
  def unused_color
    (STAMP_COLORS - stamps.map(&:color)).first
  end
  
  def available_stamp_images
    StampImage.all(:conditions => ["user_id = ? OR user_id is null", self])
  end
  
  private
  
  def map_openid_registration(registration)
    self.email = registration["email"] if email.blank?
    self.username = registration["nickname"] if username.blank?
  end
end
