class Favorite < ActiveRecord::Base
  attr_accessible :stamp_id
  belongs_to :user
  belongs_to :stamp
  validates_presence_of :stamp_id
end
