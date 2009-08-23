require File.dirname(__FILE__) + '/../spec_helper'

describe MonthCache do
  it "should generate tracker for a given month" do
    stamp = Stamp.create!
    stamp.month_caches.create!(:for_month => "2009-10-01", :score => "123")
    tracker = MonthCache.tracker_for(stamp, Date.parse("2009-10-02"))
    tracker.should be_kind_of(ScoreTracker)
    tracker.score.should == 123
  end
  
  it "should save cache from tracker" do
    stamp = Stamp.create!
    tracker = ScoreTracker.new(:score => 456)
    MonthCache.save_tracker(tracker, stamp, Date.parse("2009-10-02"))
    tracker = MonthCache.tracker_for(stamp, Date.parse("2009-10-03"))
    tracker.score.should == 456
  end
end
