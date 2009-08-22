class Stamp < ActiveRecord::Base
  attr_accessible :name, :private
  belongs_to :user
  has_many :marks, :dependent => :destroy
end
