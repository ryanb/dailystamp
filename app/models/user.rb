class User < ActiveRecord::Base
  acts_as_authentic
  has_many :stamps
  has_many :stamp_images
end
