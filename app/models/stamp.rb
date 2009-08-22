class Stamp < ActiveRecord::Base
  extend ActiveSupport::Memoizable
  
  attr_accessible :name, :private
  belongs_to :user
  has_many :marks, :dependent => :destroy
  
  def month_points(date)
    @tracker = last_month_tracker(date) || ScoreTracker.new
    (date.beginning_of_month..date.end_of_month).map do |day|
      marks.find_by_marked_on(day) ? @tracker.mark : @tracker.miss
    end
  end
  memoize :month_points
  
  # TODO remove duplication
  def month_tracker(date)
    @tracker = last_month_tracker(date) || ScoreTracker.new
    (date.beginning_of_month..date.end_of_month).each do |day|
      marks.find_by_marked_on(day) ? @tracker.mark : @tracker.miss
    end
    @tracker
  end
  
  def last_month_tracker(date)
    if marks.exists?(["marked_on < ?", date.beginning_of_month])
      month_tracker(date.beginning_of_month-1.day)
    end
  end
  
  def day_points(date)
    month_points(date.beginning_of_month)[date.day-1]
  end
end
