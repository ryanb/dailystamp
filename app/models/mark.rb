class Mark < ActiveRecord::Base
  attr_accessible :skip, :marked_on
  belongs_to :stamp
end
