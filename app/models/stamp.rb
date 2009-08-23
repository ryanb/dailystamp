class Stamp < ActiveRecord::Base
  extend ActiveSupport::Memoizable
  
  attr_accessible :name, :private, :color
  belongs_to :user
  has_many :marks, :dependent => :destroy
  
  def day_points(date)
    month_points(date.beginning_of_month)[date.day-1]
  end
  
  def month_points(date)
    tracker = last_month_tracker(date) || ScoreTracker.new
    track_month_points(tracker, date)
  end
  memoize :month_points
  
  def score
    score_cache || calculate_score
  end
  
  def color
    read_attribute(:color).blank? ? "red" : read_attribute(:color)
  end
  
  private
  
  def mark_on_day(date)
    marks_in_month(date.beginning_of_month).detect { |m| m.marked_on == date }
  end
  
  def marks_in_month(date)
    marks.all(:conditions => {:marked_on => date.beginning_of_month..date.end_of_month})
  end
  memoize :marks_in_month
  
  # TODO remove duplication
  def month_tracker(date)
    tracker = last_month_tracker(date) || ScoreTracker.new
    track_month_points(tracker, date)
    tracker
  end
  
  def track_month_points(tracker, date)
    finished = (last_mark && last_mark.marked_on < date.beginning_of_month)
    (date.beginning_of_month..date.end_of_month).map do |day|
      if finished
        0
      elsif mark_on_day(day)
        finished = true if mark_on_day(day) == last_mark
        points = mark_on_day(day).skip? ? tracker.skip : tracker.mark
        update_attribute(:score_cache, tracker.score) if finished
        points
      else
        tracker.miss
      end
    end
  end
  
  def last_month_tracker(date)
    if marks.exists?(["marked_on < ?", date.beginning_of_month])
      month_tracker(date.beginning_of_month-1.day)
    end
  end
  
  def last_mark
    @last_mark ||= marks.last(:order => "marked_on")
  end
  
  def calculate_score
    if last_mark
      month_points(last_mark.marked_on)
      score_cache
    else
      0
    end
  end
end
