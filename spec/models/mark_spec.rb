require File.dirname(__FILE__) + '/../spec_helper'

describe Mark do
  it "should clear score cache of stamp when creating" do
    stamp = Stamp.create!
    stamp.update_attribute(:score_cache, 123)
    stamp.marks.create!(:marked_on => Date.today)
    stamp.reload.score_cache.should be_nil
  end
  
  it "should clear score cache of stamp when destroying" do
    stamp = Stamp.create!
    stamp.marks.create!(:marked_on => Date.today)
    stamp.update_attribute(:score_cache, 123)
    stamp.marks.first.destroy
    stamp.reload.score_cache.should be_nil
  end
  
  it "image_path should use stamp image" do
    stamp = Stamp.new(:color => "blue")
    stamp_image = stamp.build_stamp_image(:photo_file_name => "foo.jpg")
    mark = stamp.marks.build
    mark.stamp = stamp
    mark.image_path.should == stamp_image.photo.url("blue").sub(/[^\.]+$/, "png")
  end
  
  it "should clear future month cache of stamp when creating" do
    stamp = Stamp.create!
    cache1 = stamp.month_caches.create!(:for_month => 2.months.ago)
    cache2 = stamp.month_caches.create!(:for_month => Date.today.beginning_of_month)
    stamp.marks.create!(:marked_on => Date.today)
    MonthCache.exists?(cache1).should be_true
    MonthCache.exists?(cache2).should be_false
  end
end
