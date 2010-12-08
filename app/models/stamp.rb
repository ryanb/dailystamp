class Stamp < ActiveRecord::Base
  extend ActiveSupport::Memoizable
  
  belongs_to :user
  belongs_to :stamp_image
  has_many :marks, :dependent => :destroy
  has_many :month_caches, :dependent => :destroy
  
  attr_accessible :name, :private, :color, :stamp_image_id, :goal_score, :goal_reward
  validates_presence_of :name
  
  scope :non_private, where("private != ?", true)
  scope :recent, where("score_cache > 0").order("updated_at desc")
  
  before_create :default_goal
  
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
  
  def goal_progress
    if goal_reached?
      100
    elsif goal_score.nil? || goal_score.zero?
      0
    else
      (score.to_f/goal_score*100).floor
    end
  end
  
  def goal_reached?
    score >= (goal_score || 0)
  end
  
  private
  
  def mark_on_day(date)
    marks_in_month(date.beginning_of_month).detect { |m| m.marked_on == date }
  end
  
  def marks_in_month(date)
    marks.all(:conditions => {:marked_on => date.beginning_of_month..date.end_of_month})
  end
  memoize :marks_in_month
  
  def month_tracker(date)
    tracker = last_month_tracker(date) || ScoreTracker.new
    track_month_points(tracker, date)
    MonthCache.save_tracker(tracker, self, date)
    tracker
  end
  
  def track_month_points(tracker, date)
    finished = (last_mark && last_mark.marked_on < date.beginning_of_month)
    (date.beginning_of_month..date.end_of_month).map do |day|
      if finished
        0
      elsif mark_on_day(day)
        finished = true if last_mark.nil? || last_mark.marked_on <= day
        points = mark_on_day(day).skip? ? tracker.skip : tracker.mark
        update_attribute(:score_cache, tracker.score) if finished
        points
      else
        tracker.miss
      end
    end
  end
  
  def last_month_tracker(date)
    last_month = date.beginning_of_month-1.day
    if marks.exists?(["marked_on <= ?", last_month])
      MonthCache.tracker_for(self, last_month) || month_tracker(last_month)
    end
  end
  
  def last_mark
    @last_mark ||= marks.last(:conditions => ["skip != ?", true], :order => "marked_on")
  end
  
  def calculate_score
    if last_mark
      month_points(last_mark.marked_on)
      score_cache
    else
      0
    end
  end
  
  def default_goal
    self.goal_score ||= 100
  end
end
