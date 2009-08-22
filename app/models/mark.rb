class Mark < ActiveRecord::Base
  attr_accessible :skip, :marked_on, :position_x, :position_y
  belongs_to :stamp
end
