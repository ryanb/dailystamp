require File.dirname(__FILE__) + '/../spec_helper'

describe Stamp do
  it "month points should be zero if no marks" do
    stamp = Stamp.create!
    stamp.month_points(Date.new(2009, 1)).should == [0] * 31
  end
  
  it "month points should be 1 on first mark but -1 on next miss" do
    stamp = Stamp.create!
    stamp.marks.create!(:marked_on => "2009-02-01")
    stamp.month_points(Date.new(2009, 2)).should == [1, -1] + [0]*26
  end
  
  it "month points should build up points and tear down points" do
    stamp = Stamp.create!
    ["2009-04-01", "2009-04-02", "2009-04-03", "2009-04-04", "2009-04-07"].each do |date|
      stamp.marks.create!(:marked_on => date)
    end
    stamp.month_points(Date.new(2009, 4, 3)).should == [1, 2, 2, 3, -1, -2, 2, -1, -2, -2] + [0]*20
  end
  
  it "month points should apply score to previous month" do
    stamp = Stamp.create!
    ["2009-03-31", "2009-04-01"].each do |date|
      stamp.marks.create!(:marked_on => date)
    end
    stamp.month_points(Date.new(2009, 4, 3)).should == [2, -1, -2] + [0]*27
  end
  
  it "it should have points for a specific day" do
    stamp = Stamp.create!
    stamp.marks.create!(:marked_on => "2009-04-01")
    stamp.day_points(Date.new(2009, 4, 2)).should == -1
  end
end
