class MonthCache < ActiveRecord::Base
  belongs_to :stamp
  
  def self.tracker_for(stamp, date)
    month_cache = stamp.month_caches.first(:conditions => { :for_month => date.beginning_of_month })
    ScoreTracker.new(month_cache.attributes.symbolize_keys) if month_cache
  end
  
  def self.save_tracker(tracker, stamp, date)
    stamp.month_caches.create!(
      :score => tracker.score,
      :positive_points => tracker.positive_points,
      :negative_points => tracker.negative_points,
      :position => tracker.position,
      :for_month => date.beginning_of_month
    )
  end
end
