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
    stamp_image = stamp.build_stamp_image(:photo_file_name => "foo.png")
    mark = stamp.marks.build
    mark.stamp = stamp
    mark.image_path.should == stamp_image.photo.url("blue")
  end
end
