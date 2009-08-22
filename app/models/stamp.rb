class Stamp < ActiveRecord::Base
  attr_accessible :name, :private
  belongs_to :user
  has_many :marks, :dependent => :destroy
  
  def month_points(year, month)
    @tracker = ScoreTracker.new
    start = Date.new(year, month)
    (start..start.end_of_month).map do |day|
      if marks.find_by_marked_on(day)
        @tracker.mark
      else
        @tracker.miss
      end
    end
  end
end
