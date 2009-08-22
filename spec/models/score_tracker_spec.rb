require File.dirname(__FILE__) + '/../spec_helper'

describe ScoreTracker do
  before(:each) do
    @tracker = ScoreTracker.new
  end
  
  it "should be zero by default" do
    @tracker.score.should be_zero
  end
  
  it "marks should build up" do
    (1..4).map { @tracker.mark }.should == [1, 2, 2, 3]
  end
  
  it "stay at zero when missing" do
    (1..4).map { @tracker.miss }.should == [0, 0, 0, 0]
  end
  
  it "misses should detract points" do
    4.times { @tracker.mark }
    (1..5).map { @tracker.miss }.should == [-1, -2, -2, -3, 0]
  end
  
  it "should slowly deduct positive points when misses" do
    4.times { @tracker.mark }
    2.times { @tracker.miss }
    @tracker.mark.should == 2
  end
  
  it "should reset position when mark is after misses" do
    4.times { @tracker.miss }
    @tracker.mark.should == 1
  end
  
  it "should alternate misses and marks properly" do
    [@tracker.mark, @tracker.miss, @tracker.mark, @tracker.miss].should == [1, -1, 1, -1]
  end
  
  it "should handle complex scenarios" do
    [@tracker.mark, @tracker.mark, @tracker.mark, @tracker.miss, @tracker.mark, @tracker.mark,
      @tracker.miss, @tracker.miss, @tracker.miss, @tracker.miss, @tracker.mark].should ==
      [1, 2, 2, -1, 2, 2, -1, -2, -2, -3, 1]
  end
end
