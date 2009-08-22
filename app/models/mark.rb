class Mark < ActiveRecord::Base
  attr_accessible :stamp_id, :skip, :marked_on
  belongs_to :stamp
end
